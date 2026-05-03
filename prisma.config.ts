import * as dotenv from 'dotenv';
import { defineConfig } from 'prisma/config';

// .env.local takes precedence over .env
dotenv.config({ path: '.env.local', override: true });
dotenv.config({ path: '.env' });

export default defineConfig({
  schema: 'prisma/schema.prisma',
  migrations: {
    path: 'prisma/migrations',
  },
  datasource: {
    url: process.env.DATABASE_URL,
  },
});
