# Inventory

REST resource backing Prisma model `Inventory` (table `inventory`).

## Routes

| Method | Path | Description |
|--------|------|-------------|
| GET    | `/api/inventory`      | List |
| GET    | `/api/inventory/:id`  | Get one |
| POST   | `/api/inventory`      | Create |
| PATCH  | `/api/inventory/:id`  | Update |
| DELETE | `/api/inventory/:id`  | Delete |

## Prisma model

See `prisma/schema.prisma` → `model Inventory`.

## Migration

`prisma/migrations/*_create_inventory/migration.sql`

## Example

```bash
curl http://rb-api.orbitalmind.xyz/api/inventory
```
