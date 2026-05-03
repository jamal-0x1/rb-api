# Product Variants

REST resource backing Prisma model `ProductVariant` (table `product_variants`).

## Routes

| Method | Path | Description |
|--------|------|-------------|
| GET    | `/api/product-variants`      | List |
| GET    | `/api/product-variants/:id`  | Get one |
| POST   | `/api/product-variants`      | Create |
| PATCH  | `/api/product-variants/:id`  | Update |
| DELETE | `/api/product-variants/:id`  | Delete |

## Prisma model

See `prisma/schema.prisma` → `model ProductVariant`.

## Migration

`prisma/migrations/*_create_product_variants/migration.sql`

## Example

```bash
curl http://rb-api.orbitalmind.xyz/api/product-variants
```
