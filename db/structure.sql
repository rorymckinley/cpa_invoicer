CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
CREATE TABLE "donors" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "donor_no" varchar(255), "initials" varchar(255), "surname" varchar(255), "title" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "titles" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "number" integer, "description" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "motives" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "number" integer, "description" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "transactions" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "receipt_number" varchar(255), "donor_id" integer, "motive_id" integer, "receipt_date" date, "amount" decimal, "created_at" datetime, "updated_at" datetime);
INSERT INTO schema_migrations (version) VALUES ('20131015150746');

INSERT INTO schema_migrations (version) VALUES ('20131019204041');

INSERT INTO schema_migrations (version) VALUES ('20131024150211');

INSERT INTO schema_migrations (version) VALUES ('20131026160946');
