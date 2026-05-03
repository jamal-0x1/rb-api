# Coupons

REST resource backing Prisma model `Coupon` (table `coupons`).

## Routes

| Method | Path | Description |
|--------|------|-------------|
| GET    | `/api/coupons`      | List |
| GET    | `/api/coupons/:id`  | Get one |
| POST   | `/api/coupons`      | Create |
| PATCH  | `/api/coupons/:id`  | Update |
| DELETE | `/api/coupons/:id`  | Delete |

## Prisma model

See `prisma/schema.prisma` → `model Coupon`.

## Migration

`prisma/migrations/*_create_coupons/migration.sql`

## Example

```bash
curl http://rb-api.orbitalmind.xyz/api/coupons
```
