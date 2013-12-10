CREATE TABLE "reports" ("id" serial primary key, "questions" integer, "questions_average" float, "answers" integer, "answers_average" float, "users" integer, "users_average" float, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL) ;
CREATE  INDEX "index_reports_on_questions" ON "reports" ("questions");
CREATE  INDEX "index_reports_on_answers" ON "reports" ("answers");
CREATE  INDEX "index_reports_on_users" ON "reports" ("users");
INSERT INTO schema_migrations (version) VALUES (20130731222239);
