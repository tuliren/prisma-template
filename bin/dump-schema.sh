#!/bin/bash

TEMP_SCHEMA="prisma/schema.prisma.temp"
SQL_DUMP="prisma/schema_dump.sql"

touch $TEMP_SCHEMA

# Pull the schema to the temp file
echo "Pulling current database schema..."
prisma db pull --print > "$TEMP_SCHEMA"

if [ $? -ne 0 ]; then
    echo "Error: Failed to pull database schema."
    exit 1
fi

# Generate the SQL schema dump
echo "Generating SQL schema dump..."
prisma migrate diff --from-empty --to-schema-datamodel "$TEMP_SCHEMA" --script > "$SQL_DUMP"

if [ $? -ne 0 ]; then
    echo "Error: Failed to generate SQL schema dump."
    rm "$TEMP_SCHEMA"
    exit 1
fi

# Remove the temp file
echo "Cleaning up..."
rm "$TEMP_SCHEMA"

# Optional: add prettier-plugin-sql and format the SQL dump
# npx prettier --write prisma/schema_dump.sql

echo "Done! SQL schema dump saved to $SQL_DUMP"
