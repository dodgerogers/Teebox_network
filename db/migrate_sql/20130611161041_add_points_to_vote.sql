ALTER TABLE "votes" ADD COLUMN "points" integer DEFAULT 0;
INSERT INTO schema_migrations (version) VALUES (20130611161041);
