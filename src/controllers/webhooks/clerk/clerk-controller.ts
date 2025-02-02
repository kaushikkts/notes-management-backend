import { Webhook } from "svix";
import prisma from "../../../db";
import { response } from "express";

const clerkController = async (req, res) => {
  const SIGNING_SECRET = process.env.CLERK_WEBHOOK_SECRET;

  if (!SIGNING_SECRET) {
    throw new Error(
      "Error: Please add SIGNING_SECRET from Clerk Dashboard to .env",
    );
  }

  // Create new Svix instance with secret
  const wh = new Webhook(SIGNING_SECRET);

  // Get headers and body
  const headers = req.headers;
  const payload = req.body;
  console.log(req.headers);
  // Get Svix headers for verification
  const svix_id = headers["svix-id"];
  const svix_timestamp = headers["svix-timestamp"];
  const svix_signature = headers["svix-signature"];

  // If there are no headers, error out
  if (!svix_id || !svix_timestamp || !svix_signature) {
    return void res.status(400).json({
      success: false,
      message: "Error: Missing svix headers",
    });
  }

  let evt;

  // Attempt to verify the incoming webhook
  // If successful, the payload will be available from 'evt'
  // If verification fails, error out and return error code
  try {
    evt = wh.verify(payload, {
      // @ts-ignore
      "svix-id": svix_id,
      // @ts-ignore
      "svix-timestamp": svix_timestamp,
      // @ts-ignore
      "svix-signature": svix_signature,
    });
  } catch (err) {
    console.log("Error: Could not verify webhook:", err.message);
    return void res.status(400).json({
      success: false,
      message: err.message,
    });
  }

  // Do something with payload
  // For this guide, log payload to console
  const { id } = evt.data;
  const eventType = evt.type;
  console.log(`Received webhook with ID ${id} and event type of ${eventType}`);
  console.log("Webhook payload:", evt.data);

  if (eventType === "user.created") {
    // Example: Send an email to the user's email address
    const email = evt.data.email_addresses[0]?.email_address;
    const id = evt.data.email_addresses[0]?.id;
    const response = await prisma.user.create({
      data: {
        id: id,
        email: email,
      },
    });
    // Assuming you have a sendEmail function that sends email
  }

  res.status(200).json({
    success: true,
    message: "Webhook received",
    res: response,
  });
};

export default clerkController;
