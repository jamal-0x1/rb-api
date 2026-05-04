ALTER TABLE "product_images"
  ADD COLUMN "variant_id" TEXT;

ALTER TABLE "product_images"
  ADD CONSTRAINT "product_images_variant_id_fkey"
  FOREIGN KEY ("variant_id") REFERENCES "product_variants"("id")
  ON DELETE SET NULL ON UPDATE CASCADE;

CREATE INDEX "product_images_variant_id_idx"
  ON "product_images"("variant_id");
