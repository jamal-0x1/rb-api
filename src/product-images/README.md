# Product Images

REST resource backing Prisma model `ProductImage` (table `product_images`).

## Routes

| Method | Path | Description |
|--------|------|-------------|
| GET    | `/api/product-images`      | List |
| GET    | `/api/product-images/:id`  | Get one |
| POST   | `/api/product-images`      | Create |
| PATCH  | `/api/product-images/:id`  | Update |
| DELETE | `/api/product-images/:id`  | Delete |

## Prisma model

See `prisma/schema.prisma` → `model ProductImage`.

## Migration

`prisma/migrations/*_create_product_images/migration.sql`

## Example

```bash
curl http://rb-api.orbitalmind.xyz/api/product-images
```
