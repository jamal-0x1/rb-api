ALTER TABLE "products"
  ADD COLUMN "meta_title"        VARCHAR(70),
  ADD COLUMN "meta_description"  VARCHAR(200),
  ADD COLUMN "short_description" VARCHAR(255),
  ADD COLUMN "brand"             VARCHAR(120),
  ADD COLUMN "mpn"               VARCHAR(120),
  ADD COLUMN "condition"         VARCHAR(20) NOT NULL DEFAULT 'new',
  ADD COLUMN "keywords"          TEXT,
  ADD COLUMN "no_index"          BOOLEAN     NOT NULL DEFAULT FALSE;

CREATE INDEX "products_brand_idx" ON "products" ("brand");
