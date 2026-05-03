# Wishlist Items

REST resource backing Prisma model `WishlistItem` (table `wishlist_items`).

## Routes

| Method | Path | Description |
|--------|------|-------------|
| GET    | `/api/wishlist-items`      | List |
| GET    | `/api/wishlist-items/:id`  | Get one |
| POST   | `/api/wishlist-items`      | Create |
| PATCH  | `/api/wishlist-items/:id`  | Update |
| DELETE | `/api/wishlist-items/:id`  | Delete |

## Prisma model

See `prisma/schema.prisma` → `model WishlistItem`.

## Migration

`prisma/migrations/*_create_wishlist_items/migration.sql`

## Example

```bash
curl http://rb-api.orbitalmind.xyz/api/wishlist-items
```
