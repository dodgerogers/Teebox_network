ALTER TABLE "users" ADD COLUMN "handicap" integer DEFAULT 0;
INSERT INTO schema_migrations (version) VALUES (20130615151635);
