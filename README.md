Notes Management App - Backend Webhooks

This repository contains the backend implementation for handling webhooks in the Notes Management App.

Running Locally

To run the backend locally, you need to set up environment variables in a .env file. Add the following variables:

DATABASE_URL=
PORT=8080
DB_USER=
DB_PASSWORD=
DB_NAME=
CLERK_WEBHOOK_SECRET=
LIVEBLOCKS_WEBHOOK_SECRET=

Steps to Run Locally

Clone the repository.

Create a .env file in the root directory and add the required variables.

Install dependencies using your package manager.

Run the application using the appropriate command (e.g., npm start or yarn start).

You can also run the server using npm run dev for development mode.

Ensure that you replace the placeholder values with the actual credentials and secrets required for your environment.

