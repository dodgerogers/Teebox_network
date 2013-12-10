ALTER TABLE "questions" ADD COLUMN "votes_count" integer DEFAULT 0;
ALTER TABLE "comments" ADD COLUMN "votes_count" integer DEFAULT 0;
ALTER TABLE "answers" ADD COLUMN "votes_count" integer DEFAULT 0;
INSERT INTO schema_migrations (version) VALUES (20130525201221);
