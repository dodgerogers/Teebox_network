FactoryGirl.define do
  factory :user do |u|
    u.sequence(:email) {|n| "test#{n}@hotmail.com"}
    u.sequence(:username) {|n| "tester#{n}" }
    u.password "password"
    u.password_confirmation "password" 
    u.remember_me true
    u.reputation 200
    u.role "admin"
  end
  
  factory :question do 
    title "slicing the ball"
    body "i cut across the ball"
    user
    youtube_url "http://youtube.com"
    video_id :video
    answers_count 5
    votes_count 5
    correct false
  end    
  
  factory :video do
    user
    file "http://#{CONFIG[:s3_bucket]}.s3.amazonaws.com/uploads/video/file/22120817-19bf-40ec-96f1-3c904772370b/3-wood-creamed.m4v"
    screenshot "https://#{CONFIG[:s3_bucket]}.s3.amazonaws.com/uploads/video/screenshot/73/3-wood-creamed.m4v.jpg"
  end
  
  factory :comment do
    user
    commentable_id :question
    commentable_type "Question"
    content "this is a useful comment"
    votes_count 5
  end
  
  factory :answer do
    user
    question_id :question
    body "you need to change your grip"
    votes_count 0
    correct false
  end
  
  factory :vote do
    user
    votable_id :answer
    votable_type "Answer"
    value 1
    points 5
  end
  
  factory :question_vote, parent: :vote do
    user
    votable_id :question
    votable_type "Question"
    value 1
    points 5
  end
  
  factory :comment_vote, parent: :vote do
    user
    votable_id :comment
    votable_type "Comment"
    value 1
    points 5
  end
  
  factory :tag do
    name "slice"
    explanation "ball curves from left to right"
    updated_by "Andy"
  end
  
  factory :activity do
     trackable_id :answer
     recipient_id :user
     owner_id :user
  end
  
  factory :report do
    answers 10
    answers_average 10
    questions 10
    questions_average 10
    users 10
    users_average 10
  end
end