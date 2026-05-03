# Payments

REST resource backing Prisma model `Payment` (table `payments`).

## Routes

| Method | Path | Description |
|--------|------|-------------|
| GET    | `/api/payments`      | List |
| GET    | `/api/payments/:id`  | Get one |
| POST   | `/api/payments`      | Create |
| PATCH  | `/api/payments/:id`  | Update |
| DELETE | `/api/payments/:id`  | Delete |

## Prisma model

See `prisma/schema.prisma` → `model Payment`.

## Migration

`prisma/migrations/*_create_payments/migration.sql`

## Example

```bash
curl http://rb-api.orbitalmind.xyz/api/payments
```
