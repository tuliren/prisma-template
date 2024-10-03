# Prisma Template

This is a Prisma template with better migration rollback support.

Native Prisma migration system has limited rollback functionality:

- A separate command is required to create a down migration.
- It can only roll back a migration when the migration fails.

See documentation [here](https://www.prisma.io/docs/orm/prisma-migrate/workflows/generating-down-migrations) for details.

Of course, down migrations should not be used in production. However, it is a common operation during development. When working on database schema change, one can seldom get everything right the first time. And it is undesirable to create multiple migrations for a single schema change, or to manually edit the migration files and database schema to fix the mistake.

The golden migration experience is from Rails, in which one can always create an up migration and a down migration for each schema change. During development, when a mistake is made, just rollback the last migration and write a new one.

This template aims to provide a similar experience for Prisma as follows.

## Database migration workflow

- Run `yarn db:create-migration` to create a new migration.
  - The normal `migration.sql` file is created under `<timestamp>-<migration-name>` directory.
  - A `down.sql` file for down migration is generated under the same directory.
- Run `yarn db:deploy` to apply the migration.
- Run `yarn db:rollback` to roll back the last migration.
  - The `down.sql` file is executed to revert the schema change in the database.
  - The record in `_prisma_migrations` table for the reverted migration is deleted.
- Manually delete the `<timestamp>-<migration-name>` directory to delete the migration files completely.
  - A script or flag will be added for this step in the future. Currently it is a manual operation.
- Change the `schema.prisma` file, and create a new migration.

## LICENSE

[MIT](LICENSE)
