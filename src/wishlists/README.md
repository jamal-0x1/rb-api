# Wishlists

REST resource backing Prisma model `Wishlist` (table `wishlists`).

## Routes

| Method | Path | Description |
|--------|------|-------------|
| GET    | `/api/wishlists`      | List |
| GET    | `/api/wishlists/:id`  | Get one |
| POST   | `/api/wishlists`      | Create |
| PATCH  | `/api/wishlists/:id`  | Update |
| DELETE | `/api/wishlists/:id`  | Delete |

## Prisma model

See `prisma/schema.prisma` → `model Wishlist`.

## Migration

`prisma/migrations/*_create_wishlists/migration.sql`

## Example

```bash
curl http://rb-api.orbitalmind.xyz/api/wishlists
```
