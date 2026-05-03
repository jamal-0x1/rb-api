# Products

REST resource backing Prisma model `Product` (table `products`).

## Routes

| Method | Path | Description |
|--------|------|-------------|
| GET    | `/api/products`      | List |
| GET    | `/api/products/:id`  | Get one |
| POST   | `/api/products`      | Create |
| PATCH  | `/api/products/:id`  | Update |
| DELETE | `/api/products/:id`  | Delete |

## Prisma model

See `prisma/schema.prisma` → `model Product`.

## Migration

`prisma/migrations/*_create_products/migration.sql`

## Example

```bash
curl http://rb-api.orbitalmind.xyz/api/products
```
