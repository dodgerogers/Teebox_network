CREATE TABLE "points" ("id" serial primary key, "user_id" integer, "pointable_id" integer, "pointable_type" character varying(255), "value" integer, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL) ;
CREATE  INDEX "index_points_on_pointable_id_and_pointable_type" ON "points" ("pointable_id", "pointable_type");
INSERT INTO schema_migrations (version) VALUES (20131206183110);
