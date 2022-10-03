CREATE TABLE "connections" (
  "departure" datetime,
  "arrival" datetime,
  "start_station" text,
  "end_station" text,
  "train_nr" integer,
  PRIMARY KEY ("departure", "arrival", "start_station", "end_station", "train_nr")
);

CREATE TABLE "trains" (
  "train_nr" integer,
  "length" integer,
  "start_station" text,
  "end_station" text,
  PRIMARY KEY ("train_nr", "start_station", "end_station")
);

CREATE TABLE "stations" (
  "name" text,
  "region" text,
  "city" text,
  "tracks" intger,
  PRIMARY KEY ("name", "region", "city")
);

CREATE TABLE "cities" (
  "region" text,
  "name" text,
  PRIMARY KEY ("region", "name")
);

ALTER TABLE "connections" ADD FOREIGN KEY ("start_station") REFERENCES "stations" ("name");

ALTER TABLE "connections" ADD FOREIGN KEY ("end_station") REFERENCES "stations" ("name");

ALTER TABLE "connections" ADD FOREIGN KEY ("train_nr") REFERENCES "trains" ("train_nr");

ALTER TABLE "trains" ADD FOREIGN KEY ("start_station") REFERENCES "stations" ("name");

ALTER TABLE "trains" ADD FOREIGN KEY ("end_station") REFERENCES "stations" ("name");

ALTER TABLE "stations" ADD FOREIGN KEY ("region", "city") REFERENCES "cities" ("region", "name");
