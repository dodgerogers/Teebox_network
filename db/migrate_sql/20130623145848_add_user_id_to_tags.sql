ALTER TABLE "tags" ADD COLUMN "user_id" integer;
INSERT INTO schema_migrations (version) VALUES (20130623145848);
