namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    User.where(role: "tester").each(&:delete_all)
    
    User.populate 10 do |u|
        u.username    = Faker::Name.name
        u.email       = Faker::Internet.email
        u.encrypted_password    = "password1"
        u.reputation  = rand(1..200)
        u.role        = "tester"
      end
    end
end