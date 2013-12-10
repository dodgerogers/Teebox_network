ALTER TABLE "reports" ADD COLUMN "answers_total" integer;
ALTER TABLE "reports" ADD COLUMN "questions_total" integer;
ALTER TABLE "reports" ADD COLUMN "users_total" integer;
INSERT INTO schema_migrations (version) VALUES (20130804043720);
