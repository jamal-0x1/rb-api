CREATE TABLE "product_images" (
    "id"         TEXT PRIMARY KEY,
    "product_id" TEXT NOT NULL,
    "url"        TEXT NOT NULL,
    "alt_text"   TEXT,
    "sort_order" INTEGER NOT NULL DEFAULT 0,
    "is_primary" BOOLEAN NOT NULL DEFAULT FALSE,
    CONSTRAINT "product_images_product_id_fkey" FOREIGN KEY ("product_id")
        REFERENCES "products"("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX "product_images_product_id_idx" ON "product_images"("product_id");
