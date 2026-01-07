const express = require("express");
const pinoHttp = require("pino-http");

const app = express();
app.use(pinoHttp());

app.get("/", (req, res) => {
  res.send("Hello from Docker Observability 👀");
});

app.get("/slow", async (req, res) => {
  await new Promise(r => setTimeout(r, 2000));
  res.send("Slow request 🐌");
});


app.listen(3000, "0.0.0.0", () => {
  console.log("App running on port 3000");
});
