CREATE TABLE "Company"
(
    "id"         TEXT         NOT NULL,
    "name"       TEXT         NOT NULL,
    "slug"       TEXT         NOT NULL,
    "url"        TEXT         NOT NULL,
    "archived"   BOOLEAN      NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Company_pkey" PRIMARY KEY ("id")
);
