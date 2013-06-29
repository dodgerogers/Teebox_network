FactoryGirl.define do
  factory :user do |u|
    u.sequence(:email) {|n| "test#{n}@hotmail.com"}
    u.sequence(:username) {|n| "tester#{n}" }
    u.password "password"
    u.password_confirmation "password" 
    u.remember_me true
    u.reputation 200
  end
  
  factory :question do 
    title "slicing the ball"
    body "i cut across the ball"
    user
    youtube_url "http://youtube.com"
    video_id :video
    answers_count 5
    votes_count 5
  end
  
  factory :invalid_question, parent: :question do
    title nil
    body nil
    user
    youtube_url "http://youtube.com"
    video_id :video
    answers_count 5
    votes_count 5
  end
    
  
  factory :video do
    user_id :user
    file "http://teebox-network.s3.amazonaws.com/uploads/video/file/22120817-19bf-40ec-96f1-3c904772370b/3-wood-creamed.m4v"
  end
  
  factory :comment do
    user_id :user
    commentable_id :question
    commentable_type "question"
    content "a comment"
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
    user_id :user
    votable_id :answer
    votable_type "Answer"
    value 1
    points 5
  end
  
  factory :tag do
    name "slice"
    explanation "ball curves from left to right"
    updated_by "Andy"
  end
end