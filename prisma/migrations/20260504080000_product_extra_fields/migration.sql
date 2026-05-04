ALTER TABLE "products"
  ADD COLUMN "specifications"     TEXT,
  ADD COLUMN "care_instructions"  TEXT,
  ADD COLUMN "attributes"         JSONB;
