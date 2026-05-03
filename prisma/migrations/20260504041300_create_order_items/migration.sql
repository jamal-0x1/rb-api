CREATE TABLE "order_items" (
    "id"                     TEXT PRIMARY KEY,
    "order_id"               TEXT NOT NULL,
    "variant_id"             TEXT NOT NULL,
    "quantity"               INTEGER NOT NULL,
    "unit_price"             DECIMAL(10,2) NOT NULL,
    "line_total"             DECIMAL(10,2) NOT NULL,
    "product_name_snapshot"  TEXT NOT NULL,
    "variant_sku_snapshot"   TEXT NOT NULL,
    CONSTRAINT "order_items_order_id_fkey" FOREIGN KEY ("order_id")
        REFERENCES "orders"("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "order_items_variant_id_fkey" FOREIGN KEY ("variant_id")
        REFERENCES "product_variants"("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE INDEX "order_items_order_id_idx" ON "order_items"("order_id");
