CREATE TABLE "votes" ("id" serial primary key, "value" integer, "votable_id" integer, "votable_type" character varying(255), "user_id" integer, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL) ;
CREATE  INDEX "index_votes_on_votable_id_and_votable_type" ON "votes" ("votable_id", "votable_type");
INSERT INTO schema_migrations (version) VALUES (20130523213415);
