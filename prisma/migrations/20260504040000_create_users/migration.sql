-- Drop legacy User table from initial db push (if exists)
DROP TABLE IF EXISTS "User" CASCADE;

CREATE TABLE "users" (
    "id"             TEXT PRIMARY KEY,
    "email"          TEXT NOT NULL,
    "password_hash"  TEXT,
    "first_name"     TEXT,
    "last_name"      TEXT,
    "phone"          TEXT,
    "role"           TEXT NOT NULL DEFAULT 'customer',
    "email_verified" BOOLEAN NOT NULL DEFAULT FALSE,
    "created_at"     TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at"     TIMESTAMP(3) NOT NULL
);

CREATE UNIQUE INDEX "users_email_key" ON "users"("email");
