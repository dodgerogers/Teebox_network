CREATE TABLE "taggings" ("id" serial primary key, "question_id" integer, "tag_id" integer, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL) ;
CREATE  INDEX "index_taggings_on_question_id" ON "taggings" ("question_id");
CREATE  INDEX "index_taggings_on_tag_id" ON "taggings" ("tag_id");
INSERT INTO schema_migrations (version) VALUES (20130621144918);
