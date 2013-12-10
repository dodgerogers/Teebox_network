ALTER TABLE "answers" ADD COLUMN "correct" boolean DEFAULT 'f';
INSERT INTO schema_migrations (version) VALUES (20130603001255);
