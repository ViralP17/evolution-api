/*
  Warnings:

  - You are about to alter the column `createdAt` on the `Chat` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `updatedAt` on the `Chat` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `createdAt` on the `Chatwoot` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `updatedAt` on the `Chatwoot` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `createdAt` on the `Contact` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `updatedAt` on the `Contact` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `createdAt` on the `Dify` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `updatedAt` on the `Dify` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `createdAt` on the `DifySetting` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `updatedAt` on the `DifySetting` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `createdAt` on the `EvolutionBot` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `updatedAt` on the `EvolutionBot` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `createdAt` on the `EvolutionBotSetting` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `updatedAt` on the `EvolutionBotSetting` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `createdAt` on the `Flowise` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `updatedAt` on the `Flowise` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `createdAt` on the `FlowiseSetting` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `updatedAt` on the `FlowiseSetting` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `disconnectionAt` on the `Instance` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `createdAt` on the `Instance` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `updatedAt` on the `Instance` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `createdAt` on the `IntegrationSession` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `updatedAt` on the `IntegrationSession` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `createdAt` on the `IsOnWhatsapp` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `updatedAt` on the `IsOnWhatsapp` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `createdAt` on the `Label` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `updatedAt` on the `Label` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `createdAt` on the `Media` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `createdAt` on the `OpenaiBot` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `updatedAt` on the `OpenaiBot` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `createdAt` on the `OpenaiCreds` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `updatedAt` on the `OpenaiCreds` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `createdAt` on the `OpenaiSetting` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `updatedAt` on the `OpenaiSetting` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `createdAt` on the `Proxy` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `updatedAt` on the `Proxy` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `createdAt` on the `Rabbitmq` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `updatedAt` on the `Rabbitmq` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `createdAt` on the `Session` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `createdAt` on the `Setting` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `updatedAt` on the `Setting` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `createdAt` on the `Sqs` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `updatedAt` on the `Sqs` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `createdAt` on the `Template` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `updatedAt` on the `Template` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `createdAt` on the `Typebot` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `updatedAt` on the `Typebot` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `createdAt` on the `TypebotSetting` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `updatedAt` on the `TypebotSetting` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `createdAt` on the `Webhook` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `updatedAt` on the `Webhook` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `createdAt` on the `Websocket` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to alter the column `updatedAt` on the `Websocket` table. The data in that column could be lost. The data in that column will be cast from `Timestamp(0)` to `Timestamp`.
  - You are about to drop the `Analytics` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[instanceId,remoteJid]` on the table `Chat` will be added. If there are existing duplicate values, this will fail.

*/
-- DropIndex
DROP INDEX `Label_labelId_instanceId_key` ON `Label`;

-- DropIndex
DROP INDEX `Media_fileName_key` ON `Media`;

-- AlterTable
ALTER TABLE `Chat` ADD COLUMN `unreadMessages` INTEGER NOT NULL DEFAULT 0,
    MODIFY `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFY `updatedAt` TIMESTAMP NULL;

-- AlterTable
ALTER TABLE `Chatwoot` MODIFY `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFY `updatedAt` TIMESTAMP NOT NULL;

-- AlterTable
ALTER TABLE `Contact` MODIFY `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFY `updatedAt` TIMESTAMP NULL;

-- AlterTable
ALTER TABLE `Dify` ADD COLUMN `splitMessages` BOOLEAN NULL DEFAULT false,
    ADD COLUMN `timePerChar` INTEGER NULL DEFAULT 50,
    MODIFY `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFY `updatedAt` TIMESTAMP NOT NULL;

-- AlterTable
ALTER TABLE `DifySetting` ADD COLUMN `splitMessages` BOOLEAN NULL DEFAULT false,
    ADD COLUMN `timePerChar` INTEGER NULL DEFAULT 50,
    MODIFY `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFY `updatedAt` TIMESTAMP NOT NULL;

-- AlterTable
ALTER TABLE `EvolutionBot` ADD COLUMN `splitMessages` BOOLEAN NULL DEFAULT false,
    ADD COLUMN `timePerChar` INTEGER NULL DEFAULT 50,
    MODIFY `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFY `updatedAt` TIMESTAMP NOT NULL;

-- AlterTable
ALTER TABLE `EvolutionBotSetting` ADD COLUMN `splitMessages` BOOLEAN NULL DEFAULT false,
    ADD COLUMN `timePerChar` INTEGER NULL DEFAULT 50,
    MODIFY `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFY `updatedAt` TIMESTAMP NOT NULL;

-- AlterTable
ALTER TABLE `Flowise` ADD COLUMN `splitMessages` BOOLEAN NULL DEFAULT false,
    ADD COLUMN `timePerChar` INTEGER NULL DEFAULT 50,
    MODIFY `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFY `updatedAt` TIMESTAMP NOT NULL;

-- AlterTable
ALTER TABLE `FlowiseSetting` ADD COLUMN `splitMessages` BOOLEAN NULL DEFAULT false,
    ADD COLUMN `timePerChar` INTEGER NULL DEFAULT 50,
    MODIFY `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFY `updatedAt` TIMESTAMP NOT NULL;

-- AlterTable
ALTER TABLE `Instance` MODIFY `disconnectionAt` TIMESTAMP NULL,
    MODIFY `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFY `updatedAt` TIMESTAMP NULL,
    MODIFY `isOn` BOOLEAN NULL DEFAULT false;

-- AlterTable
ALTER TABLE `IntegrationSession` MODIFY `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFY `updatedAt` TIMESTAMP NOT NULL;

-- AlterTable
ALTER TABLE `IsOnWhatsapp` ADD COLUMN `lid` VARCHAR(100) NULL,
    MODIFY `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFY `updatedAt` TIMESTAMP NOT NULL;

-- AlterTable
ALTER TABLE `Label` MODIFY `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFY `updatedAt` TIMESTAMP NOT NULL;

-- AlterTable
ALTER TABLE `Media` MODIFY `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP;

-- AlterTable
ALTER TABLE `Message` ADD COLUMN `status` VARCHAR(30) NULL;

-- AlterTable
ALTER TABLE `OpenaiBot` ADD COLUMN `splitMessages` BOOLEAN NULL DEFAULT false,
    ADD COLUMN `timePerChar` INTEGER NULL DEFAULT 50,
    MODIFY `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFY `updatedAt` TIMESTAMP NOT NULL;

-- AlterTable
ALTER TABLE `OpenaiCreds` MODIFY `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFY `updatedAt` TIMESTAMP NOT NULL;

-- AlterTable
ALTER TABLE `OpenaiSetting` ADD COLUMN `splitMessages` BOOLEAN NULL DEFAULT false,
    ADD COLUMN `timePerChar` INTEGER NULL DEFAULT 50,
    MODIFY `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFY `updatedAt` TIMESTAMP NOT NULL;

-- AlterTable
ALTER TABLE `Proxy` MODIFY `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFY `updatedAt` TIMESTAMP NOT NULL;

-- AlterTable
ALTER TABLE `Rabbitmq` MODIFY `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFY `updatedAt` TIMESTAMP NOT NULL;

-- AlterTable
ALTER TABLE `Session` ADD COLUMN `domain` VARCHAR(100) NULL,
    MODIFY `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- AlterTable
ALTER TABLE `Setting` ADD COLUMN `wavoipToken` VARCHAR(100) NULL,
    MODIFY `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFY `updatedAt` TIMESTAMP NOT NULL;

-- AlterTable
ALTER TABLE `Sqs` MODIFY `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFY `updatedAt` TIMESTAMP NOT NULL;

-- AlterTable
ALTER TABLE `Template` MODIFY `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFY `updatedAt` TIMESTAMP NOT NULL;

-- AlterTable
ALTER TABLE `Typebot` MODIFY `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFY `updatedAt` TIMESTAMP NULL;

-- AlterTable
ALTER TABLE `TypebotSetting` MODIFY `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFY `updatedAt` TIMESTAMP NOT NULL;

-- AlterTable
ALTER TABLE `Webhook` MODIFY `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFY `updatedAt` TIMESTAMP NOT NULL,
    MODIFY `domain` VARCHAR(191) NULL,
    MODIFY `webhook_limit` BOOLEAN NULL DEFAULT false;

-- AlterTable
ALTER TABLE `Websocket` MODIFY `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFY `updatedAt` TIMESTAMP NOT NULL;

-- DropTable
DROP TABLE `Analytics`;

-- CreateTable
CREATE TABLE `Nats` (
    `id` VARCHAR(191) NOT NULL,
    `enabled` BOOLEAN NOT NULL DEFAULT false,
    `events` JSON NOT NULL,
    `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP NOT NULL,
    `instanceId` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Nats_instanceId_key`(`instanceId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Kafka` (
    `id` VARCHAR(191) NOT NULL,
    `enabled` BOOLEAN NOT NULL DEFAULT false,
    `events` JSON NOT NULL,
    `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP NOT NULL,
    `instanceId` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Kafka_instanceId_key`(`instanceId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Pusher` (
    `id` VARCHAR(191) NOT NULL,
    `enabled` BOOLEAN NOT NULL DEFAULT false,
    `appId` VARCHAR(100) NOT NULL,
    `key` VARCHAR(100) NOT NULL,
    `secret` VARCHAR(100) NOT NULL,
    `cluster` VARCHAR(100) NOT NULL,
    `useTLS` BOOLEAN NOT NULL DEFAULT false,
    `events` JSON NOT NULL,
    `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP NOT NULL,
    `instanceId` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Pusher_instanceId_key`(`instanceId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `N8n` (
    `id` VARCHAR(191) NOT NULL,
    `enabled` BOOLEAN NOT NULL DEFAULT true,
    `description` VARCHAR(255) NULL,
    `webhookUrl` VARCHAR(255) NULL,
    `basicAuthUser` VARCHAR(255) NULL,
    `basicAuthPass` VARCHAR(255) NULL,
    `expire` INTEGER NULL DEFAULT 0,
    `keywordFinish` VARCHAR(100) NULL,
    `delayMessage` INTEGER NULL,
    `unknownMessage` VARCHAR(100) NULL,
    `listeningFromMe` BOOLEAN NULL DEFAULT false,
    `stopBotFromMe` BOOLEAN NULL DEFAULT false,
    `keepOpen` BOOLEAN NULL DEFAULT false,
    `debounceTime` INTEGER NULL,
    `ignoreJids` JSON NULL,
    `splitMessages` BOOLEAN NULL DEFAULT false,
    `timePerChar` INTEGER NULL DEFAULT 50,
    `triggerType` ENUM('all', 'keyword', 'none', 'advanced') NULL,
    `triggerOperator` ENUM('contains', 'equals', 'startsWith', 'endsWith', 'regex') NULL,
    `triggerValue` VARCHAR(191) NULL,
    `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP NOT NULL,
    `instanceId` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `N8nSetting` (
    `id` VARCHAR(191) NOT NULL,
    `expire` INTEGER NULL DEFAULT 0,
    `keywordFinish` VARCHAR(100) NULL,
    `delayMessage` INTEGER NULL,
    `unknownMessage` VARCHAR(100) NULL,
    `listeningFromMe` BOOLEAN NULL DEFAULT false,
    `stopBotFromMe` BOOLEAN NULL DEFAULT false,
    `keepOpen` BOOLEAN NULL DEFAULT false,
    `debounceTime` INTEGER NULL,
    `ignoreJids` JSON NULL,
    `splitMessages` BOOLEAN NULL DEFAULT false,
    `timePerChar` INTEGER NULL DEFAULT 50,
    `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP NOT NULL,
    `n8nIdFallback` VARCHAR(100) NULL,
    `instanceId` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `N8nSetting_instanceId_key`(`instanceId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Evoai` (
    `id` VARCHAR(191) NOT NULL,
    `enabled` BOOLEAN NOT NULL DEFAULT true,
    `description` VARCHAR(255) NULL,
    `agentUrl` VARCHAR(255) NULL,
    `apiKey` VARCHAR(255) NULL,
    `expire` INTEGER NULL DEFAULT 0,
    `keywordFinish` VARCHAR(100) NULL,
    `delayMessage` INTEGER NULL,
    `unknownMessage` VARCHAR(100) NULL,
    `listeningFromMe` BOOLEAN NULL DEFAULT false,
    `stopBotFromMe` BOOLEAN NULL DEFAULT false,
    `keepOpen` BOOLEAN NULL DEFAULT false,
    `debounceTime` INTEGER NULL,
    `ignoreJids` JSON NULL,
    `splitMessages` BOOLEAN NULL DEFAULT false,
    `timePerChar` INTEGER NULL DEFAULT 50,
    `triggerType` ENUM('all', 'keyword', 'none', 'advanced') NULL,
    `triggerOperator` ENUM('contains', 'equals', 'startsWith', 'endsWith', 'regex') NULL,
    `triggerValue` VARCHAR(191) NULL,
    `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP NOT NULL,
    `instanceId` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `EvoaiSetting` (
    `id` VARCHAR(191) NOT NULL,
    `expire` INTEGER NULL DEFAULT 0,
    `keywordFinish` VARCHAR(100) NULL,
    `delayMessage` INTEGER NULL,
    `unknownMessage` VARCHAR(100) NULL,
    `listeningFromMe` BOOLEAN NULL DEFAULT false,
    `stopBotFromMe` BOOLEAN NULL DEFAULT false,
    `keepOpen` BOOLEAN NULL DEFAULT false,
    `debounceTime` INTEGER NULL,
    `ignoreJids` JSON NULL,
    `splitMessages` BOOLEAN NULL DEFAULT false,
    `timePerChar` INTEGER NULL DEFAULT 50,
    `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP NOT NULL,
    `evoaiIdFallback` VARCHAR(100) NULL,
    `instanceId` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `EvoaiSetting_instanceId_key`(`instanceId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
CREATE INDEX `Chat_remoteJid_idx` ON `Chat`(`remoteJid`);

-- CreateIndex
CREATE UNIQUE INDEX `Chat_instanceId_remoteJid_key` ON `Chat`(`instanceId`, `remoteJid`);

-- CreateIndex
CREATE INDEX `Contact_remoteJid_idx` ON `Contact`(`remoteJid`);

-- CreateIndex
CREATE INDEX `Setting_instanceId_idx` ON `Setting`(`instanceId`);

-- CreateIndex
CREATE INDEX `Webhook_instanceId_idx` ON `Webhook`(`instanceId`);

-- AddForeignKey
ALTER TABLE `Nats` ADD CONSTRAINT `Nats_instanceId_fkey` FOREIGN KEY (`instanceId`) REFERENCES `Instance`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Kafka` ADD CONSTRAINT `Kafka_instanceId_fkey` FOREIGN KEY (`instanceId`) REFERENCES `Instance`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Pusher` ADD CONSTRAINT `Pusher_instanceId_fkey` FOREIGN KEY (`instanceId`) REFERENCES `Instance`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `N8n` ADD CONSTRAINT `N8n_instanceId_fkey` FOREIGN KEY (`instanceId`) REFERENCES `Instance`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `N8nSetting` ADD CONSTRAINT `N8nSetting_n8nIdFallback_fkey` FOREIGN KEY (`n8nIdFallback`) REFERENCES `N8n`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `N8nSetting` ADD CONSTRAINT `N8nSetting_instanceId_fkey` FOREIGN KEY (`instanceId`) REFERENCES `Instance`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Evoai` ADD CONSTRAINT `Evoai_instanceId_fkey` FOREIGN KEY (`instanceId`) REFERENCES `Instance`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `EvoaiSetting` ADD CONSTRAINT `EvoaiSetting_evoaiIdFallback_fkey` FOREIGN KEY (`evoaiIdFallback`) REFERENCES `Evoai`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `EvoaiSetting` ADD CONSTRAINT `EvoaiSetting_instanceId_fkey` FOREIGN KEY (`instanceId`) REFERENCES `Instance`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- RenameIndex
ALTER TABLE `Chat` RENAME INDEX `Chat_instanceId_fkey` TO `Chat_instanceId_idx`;

-- RenameIndex
ALTER TABLE `Contact` RENAME INDEX `Contact_instanceId_fkey` TO `Contact_instanceId_idx`;

-- RenameIndex
ALTER TABLE `Message` RENAME INDEX `Message_instanceId_fkey` TO `Message_instanceId_idx`;

-- RenameIndex
ALTER TABLE `MessageUpdate` RENAME INDEX `MessageUpdate_instanceId_fkey` TO `MessageUpdate_instanceId_idx`;

-- RenameIndex
ALTER TABLE `MessageUpdate` RENAME INDEX `MessageUpdate_messageId_fkey` TO `MessageUpdate_messageId_idx`;
