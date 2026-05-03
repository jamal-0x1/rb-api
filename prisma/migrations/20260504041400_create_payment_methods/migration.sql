CREATE TABLE "payment_methods" (
    "id"             TEXT PRIMARY KEY,
    "user_id"        TEXT NOT NULL,
    "provider"       TEXT NOT NULL,
    "provider_token" TEXT NOT NULL,
    "brand"          TEXT,
    "last4"          TEXT,
    "exp_month"      INTEGER,
    "exp_year"       INTEGER,
    "is_default"     BOOLEAN NOT NULL DEFAULT FALSE,
    "created_at"     TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "payment_methods_user_id_fkey" FOREIGN KEY ("user_id")
        REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX "payment_methods_user_id_idx" ON "payment_methods"("user_id");
