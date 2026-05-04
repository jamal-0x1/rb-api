-- Switch default currency from USD to BDT and migrate existing rows.

ALTER TABLE "products" ALTER COLUMN "currency" SET DEFAULT 'BDT';
ALTER TABLE "orders"   ALTER COLUMN "currency" SET DEFAULT 'BDT';
ALTER TABLE "payments" ALTER COLUMN "currency" SET DEFAULT 'BDT';

UPDATE "products" SET "currency" = 'BDT' WHERE "currency" = 'USD';
UPDATE "orders"   SET "currency" = 'BDT' WHERE "currency" = 'USD';
UPDATE "payments" SET "currency" = 'BDT' WHERE "currency" = 'USD';
