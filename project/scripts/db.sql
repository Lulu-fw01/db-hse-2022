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

CREATE TABLE "users" (
  "email" text PRIMARY KEY,
  "name" varchar(32) CONSTRAINT username_check CHECK (char_length(name) >= 2),
  "login" varchar(20) UNIQUE NOT NULL CONSTRAINT login_check CHECK (char_length(login) >= 2),
  "password" text NOT NULL CONSTRAINT password_check CHECK (char_length(password) >= 8),
  "birthday" date,
  "role" user_role DEFAULT 'user',
  "is_blocked" boolean NOT NULL DEFAULT false
);

CREATE TABLE "guides" (
  "id" bigserial PRIMARY KEY,
  "creator_email" text NOT NULL REFERENCES users(email),
  "title" varchar(50) NOT NULL CONSTRAINT title_check CHECK (char_length(title) >= 1),
  "file_path" text NOT NULL,
  "edit_date" timestamp,
  "is_blocked" boolean NOT NULL DEFAULT false
);

CREATE TABLE "categories" (
  "category_name" varchar(16) PRIMARY KEY CONSTRAINT category_check CHECK (char_length(category_name) >= 2)
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
  "content" varchar(256) NOT NULL CONSTRAINT content_check CHECK (char_length(content) >= 1)
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
  "comment" varchar(256) CONSTRAINT user_report_comment_check CHECK (char_length(comment) >= 1),
  "category" report_reason NOT NULL
);

CREATE TABLE "guide_reports" (
  "id" bigserial PRIMARY KEY,
  "reporter_email" text NOT NULL REFERENCES users(email),
  "guide_id" bigint NOT NULL REFERENCES guides(id),
  "comment" varchar(256) CONSTRAINT guide_report_comment_check CHECK (char_length(comment) >= 1),
  "category" report_reason NOT NULL
);

-- 1
INSERT INTO users (email, name, login, password, birthday)
VALUES ('example@mail.com',
        'Fedor',
        'fff',
        'password',
        '2022-01-01');

-- 2
INSERT INTO guides (creator_email, title, file_path, edit_date)
VALUES ('example@mail.com',
        'Example title',
        '/example/example-guide.md',
        '2022-12-19');

-- 3
DELETE
FROM guides
WHERE id = 1;

-- 4
INSERT INTO interactions (user_email, guide_id, users_mark)
VALUES ('example@mail.com',
        1,
        -1);

-- 5
INSERT INTO comments (user_email, guide_id, edit_date, content)
VALUES ('example@mail.com',
        1,
        '2022-01-01',
        'Hello world');

-- 6
-- Пользователь должен иметь возможность посмотреть список недавно просмотренных им гайдов;
-- TODO upgrade query.
-- TODO test
SELECT int.guide_id, int.view_date, guides.title
FROM interactions int
         JOIN guides ON int.guide_id = guides.id
WHERE int.user_email = 'example@mail.com'
ORDER BY int.view_date DESC
LIMIT 10;

-- 7
INSERT INTO tags
VALUES (1,
        'example category');

-- 8
INSERT INTO categories
VALUES ('example category');

-- 9
INSERT INTO favourites
VALUES (1,
        'example@mail.com');

-- 10
DELETE
FROM favourites
WHERE guide_id = 1
  AND user_email = 'example@mail.com';

-- 11
-- TODO: протестировать на нескольких пользователях
SELECT guide_id, SUM(users_mark) as guide_rating
FROM interactions
GROUP BY guide_id
ORDER BY guide_rating
LIMIT 10;

-- 12
-- TODO: дописать join
SELECT guide_id
FROM favourites
WHERE user_email = 'example@mail.com';


-- 13
-- Пользователь может оставить жалобу на другого пользователя, выбрав категорию нарушения
INSERT INTO user_reports (reporter_email, violator_email, comment, category)
VALUES ('example@mail.com', 'test@test.com', 'сплоховал', 'spam');

-- 14
-- Пользователь может оставить жалобу на просмотренный им гайд, выбрав категорию нарушения;
INSERT INTO guide_reports (reporter_email, guide_id, comment, category)
VALUES ('example@mail.com', 1, 'спам', 'spam');

-- 15
SELECT *
FROM user_reports;

-- 16
SELECT *
FROM guide_reports;

-- 17
-- 18

-- 19
-- Модератор может заблокировать пользователя;
UPDATE users
SET is_blocked = true
WHERE email = 'test@test.com';

-- 20
UPDATE guides
SET is_blocked = true
WHERE id = 1;

-- 21
-- Модератор может разблокировать пользователя;
UPDATE users
SET is_blocked = false
WHERE email = 'test@test.com';

-- 22
UPDATE guides
SET is_blocked = false
WHERE id = 1;

-- 23
-- Пользователь может подписаться на другого пользователя;
INSERT INTO subscriptions
VALUES ('example@mail.com',
        'test@test.com');

-- 24
DELETE
FROM subscriptions
WHERE user_email = 'example@mail.com'
  AND subscription_user_email = 'test@test.com';

-- 25
SELECT subscription_user_email
FROM subscriptions
WHERE user_email = 'example@mail.com';

-- 26
SELECT user_email
FROM subscriptions
WHERE subscription_user_email = 'example@mail.com';

-- 27
SELECT guides.id, guides.title
FROM guides
WHERE guides.creator_email IN
      (SELECT subscription_user_email FROM subscriptions WHERE user_email = 'example@mail.com');

-- 28
UPDATE users
SET password = 'new_password'
WHERE email = 'example@mail.com';

-- 29
UPDATE users
SET login = 'ff'
WHERE email = 'example@mail.com';

-- 30
UPDATE users
SET birthday = '2022-01-02'
WHERE email = 'example@mail.com';