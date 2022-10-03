CREATE TABLE "patients" (
  "patient_nr" integer PRIMARY KEY,
  "name" text,
  "disease" text,
  "station_nr" integer,
  "room_nr" integer,
  "doc_nr" integer
);

CREATE TABLE "rooms" (
  "room_nr" integer,
  "beds" integer,
  "station_nr" integer,
  "admission_from" timestamp,
  "admission_to" timestamp,
  PRIMARY KEY ("room_nr", "station_nr")
);

CREATE TABLE "stations" (
  "stat_nr" integer PRIMARY KEY,
  "name" text
);

CREATE TABLE "station_personell" (
  "pers_nr" integer PRIMARY KEY,
  "station_nr" integer,
  "name" text
);

CREATE TABLE "caregivers" (
  "pers_nr" integer,
  "qualification" text
);

CREATE TABLE "doctors" (
  "pers_nr" integer PRIMARY KEY,
  "rank" text,
  "area" text
);

ALTER TABLE "patients" ADD FOREIGN KEY ("station_nr", "room_nr") REFERENCES "rooms" ("station_nr", "room_nr");

ALTER TABLE "patients" ADD FOREIGN KEY ("doc_nr") REFERENCES "doctors" ("pers_nr");

ALTER TABLE "rooms" ADD FOREIGN KEY ("station_nr") REFERENCES "stations" ("stat_nr");

ALTER TABLE "station_personell" ADD FOREIGN KEY ("station_nr") REFERENCES "stations" ("stat_nr");

ALTER TABLE "caregivers" ADD FOREIGN KEY ("pers_nr") REFERENCES "station_personell" ("pers_nr");

ALTER TABLE "doctors" ADD FOREIGN KEY ("pers_nr") REFERENCES "station_personell" ("pers_nr");
