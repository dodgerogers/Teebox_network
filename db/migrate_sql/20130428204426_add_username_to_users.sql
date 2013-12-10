ALTER TABLE "users" ADD COLUMN "username" character varying(255);
INSERT INTO schema_migrations (version) VALUES (20130428204426);
