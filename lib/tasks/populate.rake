namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    User.populate 10 do |u|
        u.username    = Faker::Name.name
        u.email       = Faker::Internet.email
        u.encrypted_password    = "password1"
        u.reputation  = rand(1..200)
        u.role        = "tester"
      end
    
    Question.populate 10 do |question|
      question.title = Populator.words(5..12).titleize
      question.body = Populator.sentences(4..8)
      question.user_id = User.all.map(&:id)
      question.votes_count = 0
      question.answers_count = 0
      question.points = 0
    end
  end
end