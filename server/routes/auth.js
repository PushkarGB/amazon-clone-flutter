const express = require("express");
const User = require("../models/user");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

const authRouter = express.Router();

//SIGN UP ROUTE
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

//SIGN IN ROUTE
authRouter.post("/api/signin", async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await User.findOne({ email });

    if (!user) {
      return res.status(400).json({ msg: "User does not exists" });
    }

    const isMatch = await bcrypt.compare(password, user.password);

    if (!isMatch) {
      return res.status(400).json({ msg: "Incorrect Password." });
    }

    const token = jwt.sign({ id: user._id }, "passwordSecretKey");
    res.json({ token, ...user._doc });
    /* 
     * '...user.doc' will deconstruct the user object and finally the json will have something like this : 
        {
    "token": "eyJhbGci1X2mU", "_id": "69412a976d10a63b33607fb6", "name": "XYZ", "email": "demouser1@gmail.com",
    "password": "$2b$10$JG0jcjQm8PHX6xKuWpWeG.K6gCEwb4lFXMC5qrX5qU87t2BI5Ht/m", "address": "","type": "user","__v": 0
        } 
     */
  } catch (e) {
    res.status(500).json({ error: e.message }); //500 - Internal Server Error
  }
});
/**
 * We use 'msg' to show validation error/issue and 'error' to show server error
 */

module.exports = authRouter;
