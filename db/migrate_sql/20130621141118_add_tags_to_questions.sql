ALTER TABLE "questions" ADD COLUMN "tags" character varying(255);
CREATE  INDEX "index_questions_on_tags" ON "questions" ("tags");
INSERT INTO schema_migrations (version) VALUES (20130621141118);
