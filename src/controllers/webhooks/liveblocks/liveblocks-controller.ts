import { WebhookHandler } from "@liveblocks/node";
import prisma from "../../../db";

const liveblocksController = async (req, res) => {
  const webhookHandler = new WebhookHandler(
    process.env.LIVEBLOCKS_WEBHOOK_SECRET,
  );

  try {
    const webhook = webhookHandler.verifyRequest({
      headers: req.headers,
      rawBody: JSON.stringify(req.body),
    });

    if (webhook.type === "roomCreated") {
      await prisma.room.create({
        data: {
          id: webhook.data?.roomId,
        },
      });
    }
  } catch (e) {
    console.log(e);
  }
  res.status(200).json({
    message: "Room created successfully in DB",
  });
};

export default liveblocksController;
