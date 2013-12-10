ALTER TABLE "users" ADD COLUMN "rank" integer DEFAULT 0;
INSERT INTO schema_migrations (version) VALUES (20130816031358);
