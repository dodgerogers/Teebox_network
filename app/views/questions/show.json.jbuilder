json.question @decorator, :title, :body, :impressions_count, :created_at, :correct
json.user @decorator.user, :username, :rank, :reputation
json.tags @decorator.tags, :name, :explanation
json.answers @decorator.answers, :body, :correct, :created_at
json.comments @decorator.comments, :content, :created_at
