CREATE TABLE "orders" (
    "id"                  TEXT PRIMARY KEY,
    "user_id"             TEXT NOT NULL,
    "order_number"        TEXT NOT NULL,
    "status"              TEXT NOT NULL DEFAULT 'pending',
    "subtotal"            DECIMAL(10,2) NOT NULL,
    "tax_amount"          DECIMAL(10,2) NOT NULL DEFAULT 0,
    "shipping_amount"     DECIMAL(10,2) NOT NULL DEFAULT 0,
    "discount_amount"     DECIMAL(10,2) NOT NULL DEFAULT 0,
    "grand_total"         DECIMAL(10,2) NOT NULL,
    "currency"            TEXT NOT NULL DEFAULT 'USD',
    "shipping_address_id" TEXT,
    "billing_address_id"  TEXT,
    "coupon_id"           TEXT,
    "placed_at"           TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "orders_user_id_fkey" FOREIGN KEY ("user_id")
        REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "orders_shipping_address_id_fkey" FOREIGN KEY ("shipping_address_id")
        REFERENCES "addresses"("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "orders_billing_address_id_fkey" FOREIGN KEY ("billing_address_id")
        REFERENCES "addresses"("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "orders_coupon_id_fkey" FOREIGN KEY ("coupon_id")
        REFERENCES "coupons"("id") ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE UNIQUE INDEX "orders_order_number_key" ON "orders"("order_number");
CREATE INDEX "orders_user_id_idx" ON "orders"("user_id");
