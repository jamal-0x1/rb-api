# Reviews

REST resource backing Prisma model `Review` (table `reviews`).

## Routes

| Method | Path | Description |
|--------|------|-------------|
| GET    | `/api/reviews`      | List |
| GET    | `/api/reviews/:id`  | Get one |
| POST   | `/api/reviews`      | Create |
| PATCH  | `/api/reviews/:id`  | Update |
| DELETE | `/api/reviews/:id`  | Delete |

## Prisma model

See `prisma/schema.prisma` → `model Review`.

## Migration

`prisma/migrations/*_create_reviews/migration.sql`

## Example

```bash
curl http://rb-api.orbitalmind.xyz/api/reviews
```
