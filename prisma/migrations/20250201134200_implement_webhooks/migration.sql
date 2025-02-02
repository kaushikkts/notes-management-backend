/*
  Warnings:

  - You are about to drop the column `name` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `password` on the `User` table. All the data in the column will be lost.
  - You are about to drop the `Category` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Collaborator` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Note` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Team` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_CollaboratorToNote` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_CollaboratorToUser` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_TeamToUser` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Note" DROP CONSTRAINT "Note_authorId_fkey";

-- DropForeignKey
ALTER TABLE "Note" DROP CONSTRAINT "Note_categoryId_fkey";

-- DropForeignKey
ALTER TABLE "_CollaboratorToNote" DROP CONSTRAINT "_CollaboratorToNote_A_fkey";

-- DropForeignKey
ALTER TABLE "_CollaboratorToNote" DROP CONSTRAINT "_CollaboratorToNote_B_fkey";

-- DropForeignKey
ALTER TABLE "_CollaboratorToUser" DROP CONSTRAINT "_CollaboratorToUser_A_fkey";

-- DropForeignKey
ALTER TABLE "_CollaboratorToUser" DROP CONSTRAINT "_CollaboratorToUser_B_fkey";

-- DropForeignKey
ALTER TABLE "_TeamToUser" DROP CONSTRAINT "_TeamToUser_A_fkey";

-- DropForeignKey
ALTER TABLE "_TeamToUser" DROP CONSTRAINT "_TeamToUser_B_fkey";

-- AlterTable
ALTER TABLE "User" DROP COLUMN "name",
DROP COLUMN "password";

-- DropTable
DROP TABLE "Category";

-- DropTable
DROP TABLE "Collaborator";

-- DropTable
DROP TABLE "Note";

-- DropTable
DROP TABLE "Team";

-- DropTable
DROP TABLE "_CollaboratorToNote";

-- DropTable
DROP TABLE "_CollaboratorToUser";

-- DropTable
DROP TABLE "_TeamToUser";

-- CreateTable
CREATE TABLE "Room" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "userId" TEXT NOT NULL,

    CONSTRAINT "Room_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StorageUpdate" (
    "id" TEXT NOT NULL,
    "roomId" TEXT NOT NULL,
    "updates" JSONB NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "StorageUpdate_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Room" ADD CONSTRAINT "Room_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StorageUpdate" ADD CONSTRAINT "StorageUpdate_roomId_fkey" FOREIGN KEY ("roomId") REFERENCES "Room"("id") ON DELETE CASCADE ON UPDATE CASCADE;
