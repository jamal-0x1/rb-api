# Tags

REST resource backing Prisma model `Tag` (table `tags`).

## Routes

| Method | Path | Description |
|--------|------|-------------|
| GET    | `/api/tags`      | List |
| GET    | `/api/tags/:id`  | Get one |
| POST   | `/api/tags`      | Create |
| PATCH  | `/api/tags/:id`  | Update |
| DELETE | `/api/tags/:id`  | Delete |

## Prisma model

See `prisma/schema.prisma` → `model Tag`.

## Migration

`prisma/migrations/*_create_tags/migration.sql`

## Example

```bash
curl http://rb-api.orbitalmind.xyz/api/tags
```
