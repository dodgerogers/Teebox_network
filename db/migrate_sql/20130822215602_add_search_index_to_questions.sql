create index questions_title on questions using gin(to_tsvector('english', title));
create index questions_body on questions using gin(to_tsvector('english', body));
INSERT INTO schema_migrations (version) VALUES (20130822215602);
