ALTER TABLE "users" ADD COLUMN "reputation" integer DEFAULT 0;
ALTER TABLE "questions" ADD COLUMN "answers_count" integer DEFAULT 0;
INSERT INTO schema_migrations (version) VALUES (20130529162108);
