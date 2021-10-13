FactoryBot.define do
  sequence(:email) { |n| "user#{n}@example.com" }

  factory :user do
    email
    password { "password" }
    password_confirmation { "password" }
  end

  factory :mission do
    title {"Mission Name"}
    content {"Content."}
    user
  end
end