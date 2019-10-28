FactoryBot.define do
  factory :player do
    active { 1 }
    jersey { rand(1..99) }
    lname { "MyString" }
    fname { "MyString" }
    display_name { "MyString" }
    team { "MyString" }
    position { "MyString" }
    height { "MyString" }
    weight { rand(180..350) }
    college { "MyString" }
    experience { "MyString" }
    birth_date { "MyString" }
    photo_url { "MyString" }
    bye_week { rand(4..12) }
    ffn_id { rand(1000..9999) }
  end
end
