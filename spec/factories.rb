FactoryGirl.define do
  factory :user do
    email "test@hotmail.com"
    password "password"
    password_confirmation  "password" 
    remember_me true
  end
  
  factory :question do
    title "slicing the ball"
    body "i cut across the ball"
    user_id :user
    youtube_url "http://youtube.com"
    video_id :video
  end
  
  factory :video do
  end
end