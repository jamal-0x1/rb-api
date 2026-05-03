# Orders

REST resource backing Prisma model `Order` (table `orders`).

## Routes

| Method | Path | Description |
|--------|------|-------------|
| GET    | `/api/orders`      | List |
| GET    | `/api/orders/:id`  | Get one |
| POST   | `/api/orders`      | Create |
| PATCH  | `/api/orders/:id`  | Update |
| DELETE | `/api/orders/:id`  | Delete |

## Prisma model

See `prisma/schema.prisma` → `model Order`.

## Migration

`prisma/migrations/*_create_orders/migration.sql`

## Example

```bash
curl http://rb-api.orbitalmind.xyz/api/orders
```
