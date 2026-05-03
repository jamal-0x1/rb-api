CREATE TABLE "wishlist_items" (
    "id"          TEXT PRIMARY KEY,
    "wishlist_id" TEXT NOT NULL,
    "variant_id"  TEXT NOT NULL,
    "added_at"    TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "wishlist_items_wishlist_id_fkey" FOREIGN KEY ("wishlist_id")
        REFERENCES "wishlists"("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "wishlist_items_variant_id_fkey" FOREIGN KEY ("variant_id")
        REFERENCES "product_variants"("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE UNIQUE INDEX "wishlist_items_wishlist_id_variant_id_key"
    ON "wishlist_items"("wishlist_id","variant_id");
