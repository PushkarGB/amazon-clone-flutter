const express = require("express");
const adminRouter = express.Router();

//Admin middleware
const admin = require("../middlewares/admin");

//Product Model/Schema
const Product = require("../models/product");

//Add Product to DB
adminRouter.post("/admin/add-product", admin, async (req, res) => {
  try {
    //get data from seller
    const {
      productName,
      description,
      category,
      price,
      quantity,
      productImages,
    } = req.body;

    let product = new Product({
      productName,
      description,
      category,
      price,
      quantity,
      productImages,
    });

    //save data on db
    product = await product.save();

    //return saved record as a response
    res.json(product);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

//Get All Products
adminRouter.get("/admin/get-products", admin, async (req, res) => {
  try {
    const products = await Product.find(); //find() without any param returns all records
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = adminRouter;
