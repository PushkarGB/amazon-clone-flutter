const express = require("express");
const productRouter = express.Router();
const auth = require("../middlewares/auth");
const Product = require("../models/product");

//to fetch all products in category => $url/api/products?category=<category_name>
productRouter.get("/api/products", auth, async (req, res) => {
  try {
    console.log(req.query.category); // query is after '?' , so category is a prop in query
    const products = await Product.find({ category: req.query.category });
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = productRouter;
