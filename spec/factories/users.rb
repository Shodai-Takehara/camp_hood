FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "test_name#{n}"}
    sequence(:email) { |n| "test#{n}@example.com"}
    sequence(:password) { "password" }
    sequence(:password_confirmation) { "password" }
  end
end
