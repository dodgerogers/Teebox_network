ALTER TABLE "reports" DROP "questions_average";
ALTER TABLE "reports" DROP "answers_average";
ALTER TABLE "reports" DROP "users_average";
INSERT INTO schema_migrations (version) VALUES (20131118225423);
