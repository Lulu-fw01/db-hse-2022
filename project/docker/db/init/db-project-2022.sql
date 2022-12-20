CREATE TYPE "user_role" AS ENUM (
  'user',
  'administrator',
  'moderator'
);

CREATE TYPE "report_reason" AS ENUM (
  'spam',
  'violence',
  'fraud'
);

CREATE TYPE "report_status" AS ENUM (
    'opened',
    'rejected',
    'resolved'
);

CREATE TABLE "users" (
  "email" text PRIMARY KEY,
  "name" varchar(32),
  "login" varchar(20) UNIQUE NOT NULL,
  "password" text NOT NULL,
  "birthday" date,
  "role" user_role DEFAULT 'user',
  "is_blocked" boolean NOT NULL DEFAULT false
);

CREATE TABLE "guides" (
  "id" bigserial PRIMARY KEY,
  "creator_email" text NOT NULL REFERENCES users(email),
  "title" varchar(50) NOT NULL,
  "file_path" text NOT NULL,
  "edit_date" timestamp,
  "is_blocked" boolean NOT NULL DEFAULT false
);

CREATE TABLE "categories" (
  "category_name" varchar(16) PRIMARY KEY
);

CREATE TABLE "tags" (
  "guide_id" bigint NOT NULL REFERENCES guides(id),
  "category_name" text NOT NULL REFERENCES categories(category_name),
  PRIMARY KEY ("guide_id", "category_name")
);

CREATE TABLE "interactions" (
  "user_email" text NOT NULL REFERENCES users(email),
  "guide_id" bigint NOT NULL REFERENCES guides(id),
  "users_mark" integer,
  "view_date" timestamp,
  PRIMARY KEY ("user_email", "guide_id")
);

CREATE TABLE "comments" (
  "id" bigserial PRIMARY KEY,
  "user_email" text NOT NULL REFERENCES users(email),
  "guide_id" bigint NOT NULL REFERENCES guides(id),
  "edit_date" timestamp,
  "content" varchar(256) NOT NULL
);

CREATE TABLE "favourites" (
  "guide_id" bigint NOT NULL REFERENCES guides(id),
  "user_email" text NOT NULL REFERENCES users(email),
  PRIMARY KEY ("guide_id", "user_email")
);

CREATE TABLE "subscriptions" (
  "user_email" text NOT NULL REFERENCES users(email),
  "subscription_user_email" text NOT NULL REFERENCES users(email),
  PRIMARY KEY ("user_email", "subscription_user_email")
);

CREATE TABLE "user_reports" (
  "id" bigserial PRIMARY KEY,
  "reporter_email" text NOT NULL REFERENCES users(email),
  "violator_email" text NOT NULL REFERENCES users(email),
  "comment" varchar(256),
  "category" report_reason NOT NULL,
  "status" report_status NOT NULL DEFAULT 'opened'
);

CREATE TABLE "guide_reports" (
  "id" bigserial PRIMARY KEY,
  "reporter_email" text NOT NULL REFERENCES users(email),
  "guide_id" bigint NOT NULL REFERENCES guides(id),
  "comment" varchar(256),
  "category" report_reason NOT NULL,
  "status" report_status NOT NULL DEFAULT 'opened'
);
