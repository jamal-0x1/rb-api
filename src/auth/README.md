# Auth

JWT bearer-token auth. bcrypt password hashing.

## Routes

| Method | Path | Auth | Description |
|--------|------|------|-------------|
| POST | `/api/auth/register` | none | Create user, return access token |
| POST | `/api/auth/login`    | none | Email/password → access token |
| GET  | `/api/auth/me`       | Bearer | Current user profile |

## Token

Issued JWT: `{ sub: userId, email, role }`. Default expiry `7d`. Sign key from `JWT_SECRET` env.

Send on protected routes:
```
Authorization: Bearer <accessToken>
```

## Env

```
JWT_SECRET=<long-random-string>
JWT_EXPIRES_IN=7d
```

## Examples

```bash
# register
curl -X POST http://localhost:3000/api/auth/register \
  -H 'Content-Type: application/json' \
  -d '{"email":"jane@x.com","password":"supersecret","firstName":"Jane"}'

# login
curl -X POST http://localhost:3000/api/auth/login \
  -H 'Content-Type: application/json' \
  -d '{"email":"jane@x.com","password":"supersecret"}'

# me (replace TOKEN)
curl http://localhost:3000/api/auth/me -H 'Authorization: Bearer TOKEN'
```

## Protect any route

```ts
import { UseGuards } from '@nestjs/common';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';
import { CurrentUser } from '../auth/current-user.decorator';

@UseGuards(JwtAuthGuard)
@Get('private')
get(@CurrentUser() user: { id: string }) { ... }
```
