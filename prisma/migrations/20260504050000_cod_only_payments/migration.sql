-- Drop payment_methods table + related FK on payments
ALTER TABLE "payments" DROP CONSTRAINT IF EXISTS "payments_payment_method_id_fkey";
ALTER TABLE "payments" DROP COLUMN IF EXISTS "payment_method_id";
DROP TABLE IF EXISTS "payment_methods" CASCADE;

-- Reshape payments for COD-only model
ALTER TABLE "payments" DROP COLUMN IF EXISTS "provider";
ALTER TABLE "payments" DROP COLUMN IF EXISTS "provider_charge_id";
ALTER TABLE "payments" DROP COLUMN IF EXISTS "processed_at";

ALTER TABLE "payments" ADD COLUMN "method" TEXT NOT NULL DEFAULT 'cod';
ALTER TABLE "payments" ADD COLUMN "collected_at" TIMESTAMP(3);
ALTER TABLE "payments" ADD COLUMN "notes" TEXT;

ALTER TABLE "payments" ALTER COLUMN "status" SET DEFAULT 'pending';
