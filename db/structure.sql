CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
CREATE TABLE "donors" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "donor_no" varchar(255), "initials" varchar(255), "surname" varchar(255), "title" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "titles" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "number" integer, "description" varchar(255), "created_at" datetime, "updated_at" datetime);
INSERT INTO schema_migrations (version) VALUES ('20131015150746');

INSERT INTO schema_migrations (version) VALUES ('20131019204041');
