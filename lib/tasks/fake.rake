require 'faker'

desc 'fill database with fake data'
namespace :task_manager do
  task fake: :environment do
    5.times do
      create_user
    end

    20.times do
      create_task
    end
  end
end

def create_user
  User.create(
    email: Faker::Internet.unique.email,
    password: Faker::Alphanumeric.alphanumeric(6)
  )
end

def create_task
  Task.create(
    name: Faker::Music::RockBand.name,
    description: Faker::Lorem.paragraph(50),
    user_id: user_ids.sample
  )
end

def user_ids
  @user_ids ||= User.ids
end
