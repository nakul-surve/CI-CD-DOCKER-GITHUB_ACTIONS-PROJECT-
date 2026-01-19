const express = require("express");
const app = express();

const PORT = 3000;

app.get("/", (req, res) => {
  res.send("CI/CD Docker Pipeline is working 🚀");
});

app.get("/health", (req, res) => {
  res.status(200).json({ status: "UP" });
});

app.listen(PORT, () => {
  console.log(`App running on port ${PORT}`);
});
