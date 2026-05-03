# Carts

REST resource backing Prisma model `Cart` (table `carts`).

## Routes

| Method | Path | Description |
|--------|------|-------------|
| GET    | `/api/carts`      | List |
| GET    | `/api/carts/:id`  | Get one |
| POST   | `/api/carts`      | Create |
| PATCH  | `/api/carts/:id`  | Update |
| DELETE | `/api/carts/:id`  | Delete |

## Prisma model

See `prisma/schema.prisma` → `model Cart`.

## Migration

`prisma/migrations/*_create_carts/migration.sql`

## Example

```bash
curl http://rb-api.orbitalmind.xyz/api/carts
```
