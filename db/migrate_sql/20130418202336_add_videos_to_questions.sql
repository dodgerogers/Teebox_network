ALTER TABLE "questions" ADD COLUMN "video_id" integer DEFAULT 0;
INSERT INTO schema_migrations (version) VALUES (20130418202336);
