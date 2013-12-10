ALTER TABLE "activities" ADD COLUMN "read" boolean DEFAULT 'f';
INSERT INTO schema_migrations (version) VALUES (20130816225806);
