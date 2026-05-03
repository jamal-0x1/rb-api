# Shipments

REST resource backing Prisma model `Shipment` (table `shipments`).

## Routes

| Method | Path | Description |
|--------|------|-------------|
| GET    | `/api/shipments`      | List |
| GET    | `/api/shipments/:id`  | Get one |
| POST   | `/api/shipments`      | Create |
| PATCH  | `/api/shipments/:id`  | Update |
| DELETE | `/api/shipments/:id`  | Delete |

## Prisma model

See `prisma/schema.prisma` → `model Shipment`.

## Migration

`prisma/migrations/*_create_shipments/migration.sql`

## Example

```bash
curl http://rb-api.orbitalmind.xyz/api/shipments
```
