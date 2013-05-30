FactoryGirl.define do
  factory :user do
    email "test@hotmail.com"
    username "tester"
    password "password"
    password_confirmation "password" 
    remember_me true
    reputation 200
  end
  
  factory :user_2 do
    email "andy@hotmail.com"
    username "andy"
    password "password"
    password_confirmation "password" 
    remember_me true
    reputation 10
  end
  
  factory :question do
    title "slicing the ball"
    body "i cut across the ball"
    user_id :user
    youtube_url "http://youtube.com"
    video_id :video
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
  end
  
  factory :answer do
    user_id :user
    question_id :question
    body "you need to change your grip"
  end
  
  factory :vote do
    user_id :user_2
    votable_type "Question"
    votable_id :question
    value 1
  end
end