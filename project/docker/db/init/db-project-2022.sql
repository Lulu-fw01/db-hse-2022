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

CREATE TABLE "guides" (
  "id" text PRIMARY KEY,
  "creator_email" text NOT NULL,
  "title" varchar(50) NOT NULL,
  "file_path" text NOT NULL,
  "edit_date" timestamp,
  "is_blocked" boolean NOT NULL DEFAULT false
);

CREATE TABLE "users" (
  "email" text PRIMARY KEY,
  "name" varchar(32),
  "login" varchar(20) UNIQUE NOT NULL,
  "password" text NOT NULL,
  "birthday" date,
  "role" user_role,
  "is_blocked" boolean NOT NULL DEFAULT false
);

CREATE TABLE "categoies" (
  "category_name" varchar(16) PRIMARY KEY
);

CREATE TABLE "tags" (
  "guide_id" text NOT NULL,
  "category_name" text NOT NULL,
  PRIMARY KEY ("guide_id", "category_name")
);

CREATE TABLE "interactions" (
  "user_email" text NOT NULL,
  "guide_id" text NOT NULL,
  "users_mark" integer,
  "view_date" timestamp,
  PRIMARY KEY ("user_email", "guide_id")
);

CREATE TABLE "comments" (
  "id" text PRIMARY KEY,
  "user_email" text NOT NULL,
  "guide_id" text NOT NULL,
  "parent_comment_id" text,
  "edit_date" timestamp,
  "content" varchar(256) NOT NULL
);

CREATE TABLE "favourites" (
  "guide_id" text NOT NULL,
  "user_email" text NOT NULL,
  PRIMARY KEY ("guide_id", "user_email")
);

CREATE TABLE "subscriptions" (
  "user_email" text NOT NULL,
  "subscription_user_email" text NOT NULL,
  PRIMARY KEY ("user_email", "subscription_user_email")
);

CREATE TABLE "user_reports" (
  "id" text PRIMARY KEY,
  "reporter_email" text NOT NULL,
  "violator_email" text NOT NULL,
  "comment" varchar(256),
  "category" report_reason NOT NULL
);

CREATE TABLE "guide_reports" (
  "id" text PRIMARY KEY,
  "reporter_email" text NOT NULL,
  "guide_id" text NOT NULL,
  "comment" varchar(256),
  "category" report_reason NOT NULL
);

ALTER TABLE "guides" ADD FOREIGN KEY ("creator_email") REFERENCES "users" ("email");

ALTER TABLE "tags" ADD FOREIGN KEY ("category_name") REFERENCES "categoies" ("category_name");

ALTER TABLE "tags" ADD FOREIGN KEY ("guide_id") REFERENCES "guides" ("id");

ALTER TABLE "interactions" ADD FOREIGN KEY ("guide_id") REFERENCES "guides" ("id");

ALTER TABLE "interactions" ADD FOREIGN KEY ("user_email") REFERENCES "users" ("email");

ALTER TABLE "comments" ADD FOREIGN KEY ("user_email") REFERENCES "users" ("email");

ALTER TABLE "comments" ADD FOREIGN KEY ("guide_id") REFERENCES "guides" ("id");

ALTER TABLE "comments" ADD FOREIGN KEY ("parent_comment_id") REFERENCES "comments" ("id");

ALTER TABLE "favourites" ADD FOREIGN KEY ("guide_id") REFERENCES "guides" ("id");

ALTER TABLE "favourites" ADD FOREIGN KEY ("user_email") REFERENCES "users" ("email");

ALTER TABLE "subscriptions" ADD FOREIGN KEY ("user_email") REFERENCES "users" ("email");

ALTER TABLE "subscriptions" ADD FOREIGN KEY ("subscription_user_email") REFERENCES "users" ("email");

ALTER TABLE "guide_reports" ADD FOREIGN KEY ("guide_id") REFERENCES "guides" ("id");

ALTER TABLE "guide_reports" ADD FOREIGN KEY ("reporter_email") REFERENCES "users" ("email");

ALTER TABLE "user_reports" ADD FOREIGN KEY ("violator_email") REFERENCES "users" ("email");

ALTER TABLE "user_reports" ADD FOREIGN KEY ("reporter_email") REFERENCES "users" ("email");
