CREATE TABLE "product_variants" (
    "id"             TEXT PRIMARY KEY,
    "product_id"     TEXT NOT NULL,
    "sku"            TEXT NOT NULL,
    "size"           TEXT,
    "color"          TEXT,
    "price_override" DECIMAL(10,2),
    "weight_grams"   INTEGER,
    "attributes"     JSONB,
    "created_at"     TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "product_variants_product_id_fkey" FOREIGN KEY ("product_id")
        REFERENCES "products"("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE UNIQUE INDEX "product_variants_sku_key" ON "product_variants"("sku");
CREATE INDEX "product_variants_product_id_idx" ON "product_variants"("product_id");
