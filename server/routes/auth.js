const express = require("express");
const User = require("../models/user");
const bcrypt = require("bcryptjs");

const authRouter = express.Router();

authRouter.post("/api/signup", async (req, res) => {
  try {
    //1. GET THE DATA FROM CLIENT
    //ex. - {'name':'xyz','email':'zyz@example.com','password':'pass@1234'}

    const { name, email, password } = req.body;

    //check if a user entry already exists in the model with the passed email
    const existingUser = await User.findOne({ email });

    //if existingUser gets some value (a user with same email already exists) , return response - Client error response (status codes 400-499)
    // we use code 400 - BAD REQUEST and also add a json msg
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with same email already exists !" });
    }

    // 2. POST THE DATA TO THE DATABASE

    //if no existing user : create a new user and save it

    //but first hash the password using bcryptjs
    const hashedPassword = await bcrypt.hash(password, 10);

    let user = new User({
      email,
      password: hashedPassword,
      name,
    });
    /*
     Does not matter what order you passed 
    because above snippet means : 
    let user = new User({
    email : email,
    password : hashedPassword,
    name : name,
    })
     */

    //saving on the database
    user = await user.save();

    //3. RETURN THE DATA TO THE USER

    //add saved details in response
    res.json(user); //status is by default 200
  } catch (e) {
    res.status(500).json({ error: e.message }); //500 - Internal Server Error
  }
});


//Demo just to see if we have understood the concepts , we will later on update this : 

authRouter.post("/api/signin", async (req, res) => {
  try {
    const { email, password } = req.body;

    const existingUser = await User.findOne({ email });

    if (!existingUser) {
      return res.status(400).json({ msg: "User does not exists" });
    }

    let msg;
    msg = (await bcrypt.compare(password, existingUser["password"]))
      ? "Login Successful"
      : "Login Failed : Invalid Password!";

    res.json({ msg });
  } catch (e) {
    res.status(500).json({ error: e.message }); //500 - Internal Server Error
  }
});

/**
 * We use 'msg' to show validation error/issue and 'error' to show server error
 */

module.exports = authRouter;
