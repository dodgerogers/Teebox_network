FactoryGirl.define do
  factory :user do
    email "test@hotmail.com"
    password "password"
    password_confirmation "password" 
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
    user_id :user
    file File.open(File.join(Rails.root, "/spec/fixtures/edited_driver_swing.m4v"))
    screenshot File.open(File.join(Rails.root, "/spec/fixtures/edited_driver_swing.m4v.jpg"))
  end
  
  factory :comment do
    user_id :user
    commentable_id :question
    commentable_type "question"
    content "a comment"
  end
end