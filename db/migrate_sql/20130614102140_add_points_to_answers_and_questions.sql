ALTER TABLE "questions" ADD COLUMN "points" integer DEFAULT 0;
ALTER TABLE "answers" ADD COLUMN "points" integer DEFAULT 0;
ALTER TABLE "comments" ADD COLUMN "points" integer DEFAULT 0;
INSERT INTO schema_migrations (version) VALUES (20130614102140);
