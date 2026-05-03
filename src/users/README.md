# Users

Customer/admin accounts. Root identity entity.

## Routes

| Method | Path | Description |
|--------|------|-------------|
| GET    | `/api/users`      | List users (newest first) |
| GET    | `/api/users/:id`  | Get user by id |
| POST   | `/api/users`      | Create user |
| PATCH  | `/api/users/:id`  | Update user |
| DELETE | `/api/users/:id`  | Delete user (cascades addresses, cart, reviews, wishlists, payment methods) |

## Schema (`users`)

| Field | Type | Notes |
|-------|------|-------|
| id | uuid | PK |
| email | text | unique |
| password_hash | text? | bcrypt/argon2 |
| first_name | text? | |
| last_name | text? | |
| phone | text? | |
| role | text | default `customer` |
| email_verified | bool | default `false` |
| created_at | timestamp | |
| updated_at | timestamp | |

## Example

```bash
curl -X POST http://rb-api.orbitalmind.xyz/api/users \
  -H 'Content-Type: application/json' \
  -d '{"email":"jane@x.com","firstName":"Jane","lastName":"Doe"}'
```
