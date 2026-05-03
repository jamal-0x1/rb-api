CREATE TABLE "shipment_items" (
    "id"            TEXT PRIMARY KEY,
    "shipment_id"   TEXT NOT NULL,
    "order_item_id" TEXT NOT NULL,
    "quantity"      INTEGER NOT NULL,
    CONSTRAINT "shipment_items_shipment_id_fkey" FOREIGN KEY ("shipment_id")
        REFERENCES "shipments"("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "shipment_items_order_item_id_fkey" FOREIGN KEY ("order_item_id")
        REFERENCES "order_items"("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
