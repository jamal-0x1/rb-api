# Shipment Items

REST resource backing Prisma model `ShipmentItem` (table `shipment_items`).

## Routes

| Method | Path | Description |
|--------|------|-------------|
| GET    | `/api/shipment-items`      | List |
| GET    | `/api/shipment-items/:id`  | Get one |
| POST   | `/api/shipment-items`      | Create |
| PATCH  | `/api/shipment-items/:id`  | Update |
| DELETE | `/api/shipment-items/:id`  | Delete |

## Prisma model

See `prisma/schema.prisma` → `model ShipmentItem`.

## Migration

`prisma/migrations/*_create_shipment_items/migration.sql`

## Example

```bash
curl http://rb-api.orbitalmind.xyz/api/shipment-items
```
