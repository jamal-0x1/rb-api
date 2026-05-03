CREATE TABLE "coupons" (
    "id"               TEXT PRIMARY KEY,
    "code"             TEXT NOT NULL,
    "discount_type"    TEXT NOT NULL,
    "discount_value"   DECIMAL(10,2) NOT NULL,
    "min_order_amount" DECIMAL(10,2),
    "usage_limit"      INTEGER,
    "times_used"       INTEGER NOT NULL DEFAULT 0,
    "valid_from"       TIMESTAMP(3),
    "valid_until"      TIMESTAMP(3),
    "active"           BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE UNIQUE INDEX "coupons_code_key" ON "coupons"("code");
