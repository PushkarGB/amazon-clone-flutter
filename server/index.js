//IMPORTS FROM PACKAGES
const express = require("express");
const mongoose = require("mongoose");
require('dotenv').config();

//IMPORTS FROM OTHER FILES
const authRouter = require("./routes/auth");

//INIT
const DB = process.env.MONGO_URI;
const PORT = process.env.PORT || 3000;
const app = express();

//MIDDLEWARE
//CLIENT -> SERVER -> CLIENT
// CLIENT -> middleware -> SERVER -> CLIENT
app.use(express.json());
app.use(authRouter);

//CONNECTIONS
mongoose
  .connect(DB)
  .then(() => {
    console.log("Connection Successful !");
  })
  .catch((e) => {
    console.log(e);
  });
/*
CREATING AN API

GET PUT POST DELETE UPDATE --> CRUD

http://<ouripaddress>/hello-world

GET - fetch data

Exercise : 
Create a GET Request giving a json response with key of name
and value of name :
{
name : Joe
}

app.get("/name", (request, result) => {
  result.json({ "name" : "Joe" });
});

app.get("/hello-world", (request, result) => {
  result.send("Hello World");
});
*/

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Connected at Port : ${PORT}`);
});
