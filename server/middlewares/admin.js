const jwt = require("jsonwebtoken");
const User = require("../models/user");

const admin = async (req, res, next) => {
  try {
    const token = req.header("x-auth-token");
    if (!token)
      return res.status(401).json({ msg: "No auth token. Access denied." }); // 401 - Unauthorized

    const verified = jwt.verify(token, "passwordSecretKey");
    if (!verified)
      return res
        .status(401)
        .json({ msg: "Token verification failed , authorization denied." });

    const user = User.findById(verified.id);
    if (user["type"] == "user" || user["type"] == "seller")
      return res
        .status(401)
        .json({msg : "You are not an Admin , authorization denied."});
      
    req.user = verified.id;
    req.token = token;
    next();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

module.exports = admin;
