# Addresses

REST resource backing Prisma model `Address` (table `addresses`).

## Routes

| Method | Path | Description |
|--------|------|-------------|
| GET    | `/api/addresses`      | List |
| GET    | `/api/addresses/:id`  | Get one |
| POST   | `/api/addresses`      | Create |
| PATCH  | `/api/addresses/:id`  | Update |
| DELETE | `/api/addresses/:id`  | Delete |

## Prisma model

See `prisma/schema.prisma` → `model Address`.

## Migration

`prisma/migrations/*_create_addresses/migration.sql`

## Example

```bash
curl http://rb-api.orbitalmind.xyz/api/addresses
```
