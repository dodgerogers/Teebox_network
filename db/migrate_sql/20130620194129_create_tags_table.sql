CREATE TABLE "tags" ("id" serial primary key, "name" character varying(255), "explanation" text, "question_id" integer, "updated_by" character varying(255), "user_id" integer, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL) ;
CREATE  INDEX "index_tags_on_user_id" ON "tags" ("user_id");
CREATE  INDEX "index_tags_on_question_id" ON "tags" ("question_id");
INSERT INTO schema_migrations (version) VALUES (20130620194129);
