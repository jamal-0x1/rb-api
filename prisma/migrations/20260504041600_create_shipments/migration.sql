CREATE TABLE "shipments" (
    "id"               TEXT PRIMARY KEY,
    "order_id"         TEXT NOT NULL,
    "carrier"          TEXT,
    "tracking_number"  TEXT,
    "status"           TEXT NOT NULL DEFAULT 'pending',
    "shipped_at"       TIMESTAMP(3),
    "delivered_at"     TIMESTAMP(3),
    "created_at"       TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "shipments_order_id_fkey" FOREIGN KEY ("order_id")
        REFERENCES "orders"("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX "shipments_order_id_idx" ON "shipments"("order_id");
