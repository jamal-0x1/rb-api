# Cart Items

REST resource backing Prisma model `CartItem` (table `cart_items`).

## Routes

| Method | Path | Description |
|--------|------|-------------|
| GET    | `/api/cart-items`      | List |
| GET    | `/api/cart-items/:id`  | Get one |
| POST   | `/api/cart-items`      | Create |
| PATCH  | `/api/cart-items/:id`  | Update |
| DELETE | `/api/cart-items/:id`  | Delete |

## Prisma model

See `prisma/schema.prisma` → `model CartItem`.

## Migration

`prisma/migrations/*_create_cart_items/migration.sql`

## Example

```bash
curl http://rb-api.orbitalmind.xyz/api/cart-items
```
