ALTER TABLE "users" ADD COLUMN "confirmation_token" character varying(255);
ALTER TABLE "users" ADD COLUMN "confirmed_at" timestamp;
ALTER TABLE "users" ADD COLUMN "confirmation_sent_at" timestamp;
ALTER TABLE "users" ADD COLUMN "unconfirmed_email" character varying(255);
CREATE UNIQUE INDEX "index_users_on_confirmation_token" ON "users" ("confirmation_token");
INSERT INTO schema_migrations (version) VALUES (20130819181152);
