CREATE TABLE "questions" ("id" serial primary key, "title" character varying(255), "body" text, "user_id" integer, "youtube_url" character varying(255), "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL) ;
CREATE  INDEX "index_questions_on_title_and_user_id" ON "questions" ("title", "user_id");
INSERT INTO schema_migrations (version) VALUES (20130415181947);
