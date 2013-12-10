ALTER TABLE "users" ADD COLUMN "role" character varying(255) DEFAULT 'standard';
INSERT INTO schema_migrations (version) VALUES (20130730192648);
