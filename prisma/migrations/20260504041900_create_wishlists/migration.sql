CREATE TABLE "wishlists" (
    "id"         TEXT PRIMARY KEY,
    "user_id"    TEXT NOT NULL,
    "name"       TEXT NOT NULL DEFAULT 'My Wishlist',
    "is_public"  BOOLEAN NOT NULL DEFAULT FALSE,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "wishlists_user_id_fkey" FOREIGN KEY ("user_id")
        REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX "wishlists_user_id_idx" ON "wishlists"("user_id");
