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
    start_time { Time.now }
    end_time { Time.now + 1.day }
    priority { 1 }
    user
  end
end