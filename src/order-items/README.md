# Order Items

REST resource backing Prisma model `OrderItem` (table `order_items`).

## Routes

| Method | Path | Description |
|--------|------|-------------|
| GET    | `/api/order-items`      | List |
| GET    | `/api/order-items/:id`  | Get one |
| POST   | `/api/order-items`      | Create |
| PATCH  | `/api/order-items/:id`  | Update |
| DELETE | `/api/order-items/:id`  | Delete |

## Prisma model

See `prisma/schema.prisma` → `model OrderItem`.

## Migration

`prisma/migrations/*_create_order_items/migration.sql`

## Example

```bash
curl http://rb-api.orbitalmind.xyz/api/order-items
```
