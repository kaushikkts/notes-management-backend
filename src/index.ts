import express, { response } from "express";
import bodyParser from "body-parser";
import cors from "cors";
const app = express();
import dotenv from "dotenv";
app.use(bodyParser.json());

import clerkController from "./controllers/webhooks/clerk/clerk-controller";
import liveblocksController from "./controllers/webhooks/liveblocks/liveblocks-controller";

app.use(cors());
dotenv.config();

app.post("/api/webhook/liveblocks", async (req, res) => {
  const response = await liveblocksController(req, res);
  res.json(response);
});

app.post(
  "/api/webhook/clerk",
  bodyParser.raw({ type: "application/json" }),

  async (req, res) => {
    const response = await clerkController(req, res);
    res.json({
      response,
    });
  },
);
app.listen(8080, () => {
  console.log("Webhook listening");
});
