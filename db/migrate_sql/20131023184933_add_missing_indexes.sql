CREATE  INDEX "index_votes_on_votable_id_and_votable_type" ON "votes" ("votable_id", "votable_type");
CREATE  INDEX "index_votes_on_user_id" ON "votes" ("user_id");
INSERT INTO schema_migrations (version) VALUES (20131023184933);
