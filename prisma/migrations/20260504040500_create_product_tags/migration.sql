CREATE TABLE "product_tags" (
    "product_id" TEXT NOT NULL,
    "tag_id"     TEXT NOT NULL,
    CONSTRAINT "product_tags_pkey" PRIMARY KEY ("product_id","tag_id"),
    CONSTRAINT "product_tags_product_id_fkey" FOREIGN KEY ("product_id")
        REFERENCES "products"("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "product_tags_tag_id_fkey" FOREIGN KEY ("tag_id")
        REFERENCES "tags"("id") ON DELETE CASCADE ON UPDATE CASCADE
);
