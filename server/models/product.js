const mongoose = require("mongoose");

const productSchema = mongoose.Schema({
  productName: {
    required: true,
    type: String,
    trim: true,
  },
  description: {
    type: String,
    trim: true,
    required: true,
  },
  category: {
    required: true,
    type: String,
  },
  price: {
    required: true,
    type: Number,
    default: 0.0,
  },
  quantity: {
    required: true,
    type: Number,
    default: 0,
  },
  productImages: [
    {
      type: String,
      required: true,
    },
  ],
});

const Product = mongoose.model("Product", productSchema);
module.exports = Product;
