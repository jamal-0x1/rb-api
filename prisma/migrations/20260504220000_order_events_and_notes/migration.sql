-- AlterTable: add nullable notes column to orders
ALTER TABLE "orders" ADD COLUMN "notes" TEXT;

-- CreateTable: order_events activity log
CREATE TABLE "order_events" (
    "id" TEXT NOT NULL,
    "order_id" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "message" TEXT NOT NULL,
    "payload" JSONB,
    "actor_user_id" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "order_events_pkey" PRIMARY KEY ("id")
);

CREATE INDEX "order_events_order_id_idx" ON "order_events"("order_id");
CREATE INDEX "order_events_created_at_idx" ON "order_events"("created_at");

ALTER TABLE "order_events"
  ADD CONSTRAINT "order_events_order_id_fkey"
  FOREIGN KEY ("order_id") REFERENCES "orders"("id")
  ON DELETE CASCADE ON UPDATE CASCADE;
