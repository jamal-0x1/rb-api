# Categories

REST resource backing Prisma model `Category` (table `categories`).

## Routes

| Method | Path | Description |
|--------|------|-------------|
| GET    | `/api/categories`      | List |
| GET    | `/api/categories/:id`  | Get one |
| POST   | `/api/categories`      | Create |
| PATCH  | `/api/categories/:id`  | Update |
| DELETE | `/api/categories/:id`  | Delete |

## Prisma model

See `prisma/schema.prisma` → `model Category`.

## Migration

`prisma/migrations/*_create_categories/migration.sql`

## Example

```bash
curl http://rb-api.orbitalmind.xyz/api/categories
```
