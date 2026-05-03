CREATE TABLE "payments" (
    "id"                 TEXT PRIMARY KEY,
    "order_id"           TEXT NOT NULL,
    "payment_method_id"  TEXT,
    "provider"           TEXT NOT NULL,
    "provider_charge_id" TEXT,
    "amount"             DECIMAL(10,2) NOT NULL,
    "currency"           TEXT NOT NULL DEFAULT 'USD',
    "status"             TEXT NOT NULL,
    "processed_at"       TIMESTAMP(3),
    "created_at"         TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "payments_order_id_fkey" FOREIGN KEY ("order_id")
        REFERENCES "orders"("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "payments_payment_method_id_fkey" FOREIGN KEY ("payment_method_id")
        REFERENCES "payment_methods"("id") ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE INDEX "payments_order_id_idx" ON "payments"("order_id");
