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
  } catch (e) {``
    res.status(500).json({ error: e.message });
  }
});

//get request to search products and get them
// call -> /api/products/search/(query ex-i) ==> access the query with req.param.name 
productRouter.get("/api/products/search/:name", auth, async (req, res) => {
  try {
    console.log(req.params.name); // query is after '?' , so category is a prop in query
    const products = await Product.find(
      {
      productName : { $regex: req.params.name, $options: "i"} 
      }
    );
    console.log(products);
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = productRouter;
