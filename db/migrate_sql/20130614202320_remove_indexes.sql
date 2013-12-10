DROP INDEX "index_answers_on_user_id_and_question_id";
DROP INDEX "index_comments_on_commentable_id_and_commentable_type";
DROP INDEX "index_questions_on_title_and_user_id";
DROP INDEX "index_videos_on_user_id_and_question_id";
DROP INDEX "index_votes_on_votable_id_and_votable_type";
INSERT INTO schema_migrations (version) VALUES (20130614202320);
