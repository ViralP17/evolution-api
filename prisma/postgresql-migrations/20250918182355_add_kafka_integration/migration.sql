-- CreateTable
CREATE TABLE "evolution_api"."Kafka" (
    "id" TEXT NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT false,
    "events" JSONB NOT NULL,
    "createdAt" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP NOT NULL,
    "instanceId" TEXT NOT NULL,

    CONSTRAINT "Kafka_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Kafka_instanceId_key" ON "evolution_api"."Kafka"("instanceId");

-- AddForeignKey
ALTER TABLE "evolution_api"."Kafka" ADD CONSTRAINT "Kafka_instanceId_fkey" FOREIGN KEY ("instanceId") REFERENCES "evolution_api"."Instance"("id") ON DELETE CASCADE ON UPDATE CASCADE;
