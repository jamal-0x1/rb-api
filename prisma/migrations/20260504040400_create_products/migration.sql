CREATE TABLE "products" (
    "id"          TEXT PRIMARY KEY,
    "category_id" TEXT,
    "sku"         TEXT NOT NULL,
    "name"        TEXT NOT NULL,
    "slug"        TEXT NOT NULL,
    "description" TEXT,
    "base_price"  DECIMAL(10,2) NOT NULL,
    "currency"    TEXT NOT NULL DEFAULT 'USD',
    "active"      BOOLEAN NOT NULL DEFAULT TRUE,
    "created_at"  TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at"  TIMESTAMP(3) NOT NULL,
    CONSTRAINT "products_category_id_fkey" FOREIGN KEY ("category_id")
        REFERENCES "categories"("id") ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE UNIQUE INDEX "products_sku_key"  ON "products"("sku");
CREATE UNIQUE INDEX "products_slug_key" ON "products"("slug");
CREATE INDEX "products_category_id_idx" ON "products"("category_id");
