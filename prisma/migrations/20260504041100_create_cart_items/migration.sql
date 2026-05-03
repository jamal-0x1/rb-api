CREATE TABLE "cart_items" (
    "id"                  TEXT PRIMARY KEY,
    "cart_id"             TEXT NOT NULL,
    "variant_id"          TEXT NOT NULL,
    "quantity"            INTEGER NOT NULL DEFAULT 1,
    "unit_price_snapshot" DECIMAL(10,2) NOT NULL,
    CONSTRAINT "cart_items_cart_id_fkey" FOREIGN KEY ("cart_id")
        REFERENCES "carts"("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "cart_items_variant_id_fkey" FOREIGN KEY ("variant_id")
        REFERENCES "product_variants"("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE INDEX "cart_items_cart_id_idx" ON "cart_items"("cart_id");
