/*
  Warnings:

  - Added the required column `LicenseKey` to the `Instance` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Instance" ADD COLUMN     "LicenseKey" TEXT NOT NULL,
ADD COLUMN     "domain" TEXT,
ADD COLUMN     "isOn" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "scanAllowed" INTEGER,
ADD COLUMN     "serverKey" TEXT;

-- AlterTable
ALTER TABLE "Session" ADD COLUMN     "domain" VARCHAR(100);

-- AlterTable
ALTER TABLE "Webhook" ADD COLUMN     "domain" TEXT,
ADD COLUMN     "webhook_limit" BOOLEAN DEFAULT false;
