FactoryBot.define do
  factory :user, aliases: [:commenter] do
    sequence(:username) { |n| "user#{n}" }
    sequence(:email) { |n| "test#{n}@example.com" }
  end
end
