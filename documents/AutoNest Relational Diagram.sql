CREATE TABLE "person" (
  "person_id" serial PRIMARY KEY,
  "name" varchar NOT NULL,
  "email_address" varchar
);

CREATE TABLE "person_phonenumber" (
  "phone_number" varchar(20),
  "person_id" serial,
  PRIMARY KEY ("phone_number", "person_id")
);

CREATE TABLE "guest" (
  "person_id" serial PRIMARY KEY,
  "visit" varchar,
  "license_plate" varchar(8)
);

CREATE TABLE "owner" (
  "person_id" serial PRIMARY KEY
);

CREATE TABLE "enforcement_officer" (
  "person_id" serial PRIMARY KEY,
  "badge_number" varchar(7) UNIQUE NOT NULL
);

CREATE TABLE "vehicle" (
  "license_plate" varchar(8) PRIMARY KEY,
  "state" varchar NOT NULL,
  "make" varchar,
  "model" varchar,
  "color" varchar,
  "guest_id" serial
);

CREATE TABLE "owner_vehicle" (
  "person_id" serial,
  "license_plate" varchar(8),
  PRIMARY KEY ("person_id", "license_plate")
);

CREATE TABLE "enforcement_validate_vehicle" (
  "person_id" serial,
  "license_plate" varchar(8),
  PRIMARY KEY ("person_id", "license_plate")
);

CREATE TABLE "permit" (
  "permit_id" serial PRIMARY KEY,
  "permit_type" varchar,
  "start_date" timestamp NOT NULL,
  "end_date" timestamp NOT NULL,
  "license_plate" varchar(8)
);

CREATE TABLE "violation" (
  "violation_id" serial PRIMARY KEY,
  "status" varchar,
  "reason" varchar NOT NULL,
  "violation_date" timestamp NOT NULL,
  "license_plate" varchar(8),
  "person_id" serial
);

ALTER TABLE "person_phonenumber" ADD FOREIGN KEY ("person_id") REFERENCES "person" ("person_id");

ALTER TABLE "guest" ADD FOREIGN KEY ("person_id") REFERENCES "person" ("person_id");

ALTER TABLE "guest" ADD FOREIGN KEY ("license_plate") REFERENCES "vehicle" ("license_plate");

ALTER TABLE "owner" ADD FOREIGN KEY ("person_id") REFERENCES "person" ("person_id");

ALTER TABLE "enforcement_officer" ADD FOREIGN KEY ("person_id") REFERENCES "person" ("person_id");

ALTER TABLE "vehicle" ADD FOREIGN KEY ("guest_id") REFERENCES "guest" ("person_id");

ALTER TABLE "owner_vehicle" ADD FOREIGN KEY ("person_id") REFERENCES "owner" ("person_id");

ALTER TABLE "owner_vehicle" ADD FOREIGN KEY ("license_plate") REFERENCES "vehicle" ("license_plate");

ALTER TABLE "enforcement_validate_vehicle" ADD FOREIGN KEY ("person_id") REFERENCES "enforcement_officer" ("person_id");

ALTER TABLE "enforcement_validate_vehicle" ADD FOREIGN KEY ("license_plate") REFERENCES "vehicle" ("license_plate");

ALTER TABLE "permit" ADD FOREIGN KEY ("license_plate") REFERENCES "vehicle" ("license_plate");

ALTER TABLE "violation" ADD FOREIGN KEY ("license_plate") REFERENCES "vehicle" ("license_plate");

ALTER TABLE "violation" ADD FOREIGN KEY ("person_id") REFERENCES "enforcement_officer" ("person_id");
