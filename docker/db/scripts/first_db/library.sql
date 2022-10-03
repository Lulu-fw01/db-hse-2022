CREATE TABLE "books" (
  "isbn" varchar PRIMARY KEY,
  "pages_num" integer,
  "year" date,
  "name" text,
  "author" text,
  "publisher_name" text
);

CREATE TABLE "books_categories" (
  "book_isbn" varchar,
  "category_name" text,
  PRIMARY KEY ("book_isbn", "category_name")
);

CREATE TABLE "categories" (
  "name" text PRIMARY KEY,
  "parent_category" text
);

CREATE TABLE "publishers" (
  "name" text PRIMARY KEY,
  "address" text
);

CREATE TABLE "book_copies" (
  "id" SERIAL,
  "isbn" varchar,
  "position" text,
  PRIMARY KEY ("id", "isbn")
);

CREATE TABLE "rented_books" (
  "book_id" integer,
  "isbn" varchar,
  "reader_id" integer,
  "return_date" date,
  PRIMARY KEY ("book_id", "isbn", "reader_id")
);

CREATE TABLE "readers" (
  "id" SERIAL PRIMARY KEY,
  "surname" text,
  "name" text,
  "address" text,
  "birthday" date
);

ALTER TABLE "books_categories" ADD FOREIGN KEY ("book_isbn") REFERENCES "books" ("isbn");

ALTER TABLE "books_categories" ADD FOREIGN KEY ("category_name") REFERENCES "categories" ("name");

ALTER TABLE "books" ADD FOREIGN KEY ("publisher_name") REFERENCES "publishers" ("name");

ALTER TABLE "categories" ADD FOREIGN KEY ("parent_category") REFERENCES "categories" ("name");

ALTER TABLE "book_copies" ADD FOREIGN KEY ("isbn") REFERENCES "books" ("isbn");

ALTER TABLE "rented_books" ADD FOREIGN KEY ("book_id", "isbn") REFERENCES "book_copies" ("id", "isbn");

ALTER TABLE "rented_books" ADD FOREIGN KEY ("reader_id") REFERENCES "readers" ("id");
