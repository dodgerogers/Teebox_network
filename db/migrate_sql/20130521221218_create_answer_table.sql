CREATE TABLE "answers" ("id" serial primary key, "body" text, "user_id" integer, "question_id" integer, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL) ;
CREATE  INDEX "index_answers_on_user_id_and_question_id" ON "answers" ("user_id", "question_id");
INSERT INTO schema_migrations (version) VALUES (20130521221218);
