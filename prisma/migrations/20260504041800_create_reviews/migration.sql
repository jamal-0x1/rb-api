CREATE TABLE "reviews" (
    "id"                TEXT PRIMARY KEY,
    "user_id"           TEXT NOT NULL,
    "product_id"        TEXT NOT NULL,
    "order_item_id"     TEXT,
    "rating"            INTEGER NOT NULL,
    "title"             TEXT,
    "body"              TEXT,
    "verified_purchase" BOOLEAN NOT NULL DEFAULT FALSE,
    "created_at"        TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "reviews_user_id_fkey" FOREIGN KEY ("user_id")
        REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "reviews_product_id_fkey" FOREIGN KEY ("product_id")
        REFERENCES "products"("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "reviews_order_item_id_fkey" FOREIGN KEY ("order_item_id")
        REFERENCES "order_items"("id") ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE INDEX "reviews_product_id_idx" ON "reviews"("product_id");
