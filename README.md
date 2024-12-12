# Prisma Template

This is a Prisma template with better migration rollback support.

Native Prisma migration system has limited rollback functionality:

- A separate command is required to create a down migration.
- It can only roll back a migration when the migration fails.

See documentation [here](https://www.prisma.io/docs/orm/prisma-migrate/workflows/generating-down-migrations) for details.

Of course, down migrations should not be used in production. However, it is a common operation during development. When working on database schema change, one can seldom get everything right the first time. And it is undesirable to create multiple migrations for a single schema change, or to manually edit the migration files and database schema to fix the mistake.

The golden migration experience is from Rails, in which one can always create an up migration and a down migration for each schema change. During development, when a mistake is made, just rollback the last migration and write a new one.

This template aims to provide a similar experience for Prisma as follows:

- Create a rollback SQL script for each migration.
- Add a rollback command to roll back the last migration.
- Add a schema dump command to pull the current schema from the database, and persist it to `prisma/schema_dump.sql`.

## Commands

| Command | Description |
| --- | --- |
| `npm run db:create-migration` | Create a new migration, together with the rollback script. |
| `npm run db:deploy` | Apply the migration, and update the schema dump. |
| `npm run db:rollback` | Roll back the last migration, delete the migration file, and update the schema dump. |
| `npm run db:generate` | Generate and update Prisma client code. |

See [`package.json`](./package.json) for more details.

## Database migration workflow

- Run `yarn db:create-migration` to create a new migration.
  - The normal `migration.sql` file is created under `<timestamp>-<migration-name>` directory.
  - A `down.sql` file for down migration is generated under the same directory.
- Run `yarn db:deploy` to apply the migration.
  - The `db:deploy` also runs `db:dump-schema` to create or update the SQL schema file at `prisma/schema_dump.sql`
  - The schema dump is updated to reflect the current schema of the database, and should be checked into source control for reference.
- Run `yarn db:rollback` to roll back the last migration.
  - The `down.sql` file is executed to revert the schema change in the database.
  - The record in `_prisma_migrations` table for the reverted migration is deleted.
  - The `<timestamp>-<migration-name>` directory is deleted.
  - The schema dump is updated.
- Change the `schema.prisma` file, and create a new migration.

## LICENSE

[MIT](LICENSE)
