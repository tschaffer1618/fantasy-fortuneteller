FactoryBot.define do
  factory :player do
    active { 1 }
    jersey { rand(1..99) }
    lname { "Rice" }
    fname { "Jerry" }
    display_name { "Jerry Rice" }
    team { "SF" }
    position { "WR" }
    height { "6,2\"" }
    weight { rand(180..350) }
    college { "MyString" }
    experience { "MyString" }
    birth_date { "MyString" }
    photo_url { "MyString" }
    bye_week { rand(4..12) }
    ffn_id { rand(1000..9999) }
    projection_week { 8 }
    current_projection { 12.34 }
    injury_status { nil }
  end
end
