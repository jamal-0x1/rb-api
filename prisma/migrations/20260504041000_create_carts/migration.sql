CREATE TABLE "carts" (
    "id"         TEXT PRIMARY KEY,
    "user_id"    TEXT,
    "session_id" TEXT,
    "coupon_id"  TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    CONSTRAINT "carts_user_id_fkey" FOREIGN KEY ("user_id")
        REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "carts_coupon_id_fkey" FOREIGN KEY ("coupon_id")
        REFERENCES "coupons"("id") ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE UNIQUE INDEX "carts_user_id_key" ON "carts"("user_id");
