CREATE TABLE "inventory" (
    "id"                 TEXT PRIMARY KEY,
    "variant_id"         TEXT NOT NULL,
    "quantity_on_hand"   INTEGER NOT NULL DEFAULT 0,
    "quantity_reserved"  INTEGER NOT NULL DEFAULT 0,
    "reorder_threshold"  INTEGER NOT NULL DEFAULT 0,
    "updated_at"         TIMESTAMP(3) NOT NULL,
    CONSTRAINT "inventory_variant_id_fkey" FOREIGN KEY ("variant_id")
        REFERENCES "product_variants"("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE UNIQUE INDEX "inventory_variant_id_key" ON "inventory"("variant_id");
