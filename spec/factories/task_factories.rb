FactoryBot.define do
  factory :task do
    sequence(:name) { |i| "Task #{i}" }
    description { 'Description' }
    user
  end
end
