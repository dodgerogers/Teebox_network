ALTER TABLE "tags" DROP "user_id";
ALTER TABLE "tags" DROP "question_id";
INSERT INTO schema_migrations (version) VALUES (20130621170049);
