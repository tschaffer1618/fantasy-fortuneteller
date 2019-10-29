FactoryBot.define do
  factory :user do
    provider { "google" }
    uid { "12345" }
    email { "mike@ditka.com" }
    first_name { "Mike" }
    last_name { "Ditka" }
    picture { "MyString" }
    user_name { 'mikey' }
  end
end
