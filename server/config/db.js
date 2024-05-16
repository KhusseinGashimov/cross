const mongoose=require('mongoose');

async function connectDB() {
    try {
      await mongoose.connect(
        "mongodb+srv://iliaskenes2005:AYISbdc84l1vGNSH@cluster0.c1tenti.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0"
      );
      console.log("Connected to MongoDBB");
    } catch (error) {
      console.error("Error connecting to MongoDB:", error);
    }
  }
  module.exports = connectDB;
