CREATE TABLE "connections" (
  "departure" timestamp,
  "arrival" timestamp,
  "start_station" text,
  "end_station" text,
  "start_city" text,
  "start_region" text,
  "end_city" text,
  "end_region" text,
  "train_nr" integer,
  PRIMARY KEY ("departure", "arrival", "start_region", "start_city", "start_station", "end_region", "end_city", "end_station", "train_nr")
);

CREATE TABLE "trains" (
  "train_nr" integer,
  "length" integer,
  "start_station" text,
  "end_station" text,
  "start_city" text,
  "start_region" text,
  "end_city" text,
  "end_region" text,
  PRIMARY KEY ("train_nr", "start_region", "start_city", "start_station", "end_region", "end_city", "end_station")
);

CREATE TABLE "stations" (
  "name" text,
  "region" text,
  "city" text,
  "tracks" integer,
  PRIMARY KEY ("name", "region", "city")
);

CREATE TABLE "cities" (
  "region" text,
  "name" text,
  PRIMARY KEY ("region", "name")
);

ALTER TABLE "connections" ADD FOREIGN KEY ("start_region", "start_city", "start_station") REFERENCES "stations" ("region", "city", "name");

ALTER TABLE "connections" ADD FOREIGN KEY ("end_region", "end_city", "end_station") REFERENCES "stations" ("region", "city", "name");

ALTER TABLE "connections" ADD FOREIGN KEY ("train_nr", "start_region", "start_city", "start_station", "end_region", "end_city", "end_station") REFERENCES "trains" ("train_nr", "start_region", "start_city", "start_station", "end_region", "end_city", "end_station");

ALTER TABLE "trains" ADD FOREIGN KEY ("start_region", "start_city", "start_station") REFERENCES "stations" ("region", "city", "name");

ALTER TABLE "trains" ADD FOREIGN KEY ("end_region", "end_city", "end_station") REFERENCES "stations" ("region", "city", "name");

ALTER TABLE "stations" ADD FOREIGN KEY ("region", "city") REFERENCES "cities" ("region", "name");
