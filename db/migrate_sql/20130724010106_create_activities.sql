CREATE TABLE "activities" ("id" serial primary key, "trackable_id" integer, "trackable_type" character varying(255), "owner_id" integer, "owner_type" character varying(255), "key" character varying(255), "parameters" text, "recipient_id" integer, "recipient_type" character varying(255), "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL) ;
CREATE  INDEX "index_activities_on_trackable_id_and_trackable_type" ON "activities" ("trackable_id", "trackable_type");
CREATE  INDEX "index_activities_on_owner_id_and_owner_type" ON "activities" ("owner_id", "owner_type");
CREATE  INDEX "index_activities_on_recipient_id_and_recipient_type" ON "activities" ("recipient_id", "recipient_type");
INSERT INTO schema_migrations (version) VALUES (20130724010106);
