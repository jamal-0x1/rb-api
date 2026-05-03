CREATE TABLE "tags" (
    "id"   TEXT PRIMARY KEY,
    "name" TEXT NOT NULL
);

CREATE UNIQUE INDEX "tags_name_key" ON "tags"("name");
