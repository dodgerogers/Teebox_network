CREATE TABLE "comments" ("id" serial primary key, "content" text, "commentable_id" integer, "commentable_type" character varying(255), "user_id" integer, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL) ;
CREATE  INDEX "index_comments_on_commentable_id_and_commentable_type" ON "comments" ("commentable_id", "commentable_type");
INSERT INTO schema_migrations (version) VALUES (20130504230613);
