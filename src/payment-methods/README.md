# Payment Methods

REST resource backing Prisma model `PaymentMethod` (table `payment_methods`).

## Routes

| Method | Path | Description |
|--------|------|-------------|
| GET    | `/api/payment-methods`      | List |
| GET    | `/api/payment-methods/:id`  | Get one |
| POST   | `/api/payment-methods`      | Create |
| PATCH  | `/api/payment-methods/:id`  | Update |
| DELETE | `/api/payment-methods/:id`  | Delete |

## Prisma model

See `prisma/schema.prisma` → `model PaymentMethod`.

## Migration

`prisma/migrations/*_create_payment_methods/migration.sql`

## Example

```bash
curl http://rb-api.orbitalmind.xyz/api/payment-methods
```
