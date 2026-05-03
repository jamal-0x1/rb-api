CREATE TABLE "addresses" (
    "id"                   TEXT PRIMARY KEY,
    "user_id"              TEXT NOT NULL,
    "label"                TEXT,
    "line1"                TEXT NOT NULL,
    "line2"                TEXT,
    "city"                 TEXT NOT NULL,
    "state"                TEXT,
    "postal_code"          TEXT NOT NULL,
    "country"              TEXT NOT NULL,
    "is_default_shipping"  BOOLEAN NOT NULL DEFAULT FALSE,
    "is_default_billing"   BOOLEAN NOT NULL DEFAULT FALSE,
    "created_at"           TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "addresses_user_id_fkey" FOREIGN KEY ("user_id")
        REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX "addresses_user_id_idx" ON "addresses"("user_id");
