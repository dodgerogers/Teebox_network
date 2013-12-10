DROP TABLE "delayed_jobs";
CREATE TABLE "delayed_jobs" ("id" serial primary key, "priority" integer DEFAULT 0, "attempts" integer DEFAULT 0, "handler" text, "last_error" text, "run_at" timestamp, "locked_at" timestamp, "failed_at" timestamp, "locked_by" character varying(255), "queue" character varying(255), "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL) ;
CREATE  INDEX "delayed_jobs_priority" ON "delayed_jobs" ("priority", "run_at");
INSERT INTO schema_migrations (version) VALUES (20130710175542);
