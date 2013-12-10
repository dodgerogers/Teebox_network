CREATE TABLE "videos" ("id" serial primary key, "file" character varying(255), "user_id" integer, "question_id" integer, "screenshot" character varying(255), "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL) ;
CREATE  INDEX "index_videos_on_user_id_and_question_id" ON "videos" ("user_id", "question_id");
INSERT INTO schema_migrations (version) VALUES (20130415195655);
