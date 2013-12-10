ALTER TABLE "questions" ADD COLUMN "correct" boolean DEFAULT 'f';
INSERT INTO schema_migrations (version) VALUES (20130614194213);
