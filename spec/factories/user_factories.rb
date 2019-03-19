FactoryBot.define do
  factory :user do
    sequence(:email) { |i| "email#{i}@example.com" }
    password              { 'password' }
    password_confirmation { 'password' }

    trait :admin do
      role { :admin }
    end
  end
end
