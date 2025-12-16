const mongoose = require("mongoose");

const userSchema = mongoose.Schema({
    name:{
        required : true,
        type : String,
        trim : true,
    },
    email:{
        type : String,
        trim : true,
        required : true,
        validate : {
            validator : (value) => {
                const re = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re);
            },
            message : "Please enter a valid Email ID.",
        },
    },
    password:{
        required : true,
        type : String,
        validate : {
            validator : (value) => {
               return value.length > 6;
            },
            message : "Password must have at least 6 characters",
        },
    },
    address:{
        type: String,
        default : ""
    },
    type:{
        type:String,
        default:"user",
    },
    //cart
});

const User = mongoose.model("User",userSchema);
module.exports = User;