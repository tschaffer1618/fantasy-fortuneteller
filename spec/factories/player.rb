FactoryBot.define do
  factory :player do
    active { 1 }
    jersey { rand(1..99) }
    sequence(:lname) {|x| "Rice #{x}"}
    fname { "Jerry" }
    sequence(:display_name) {|x| "Jerry Rice #{x}"}
    team { "SF" }
    position { "WR" }
    height { "6,2\"" }
    weight { rand(180..350) }
    college { "MyString" }
    experience { "MyString" }
    birth_date { "MyString" }
    photo_url { 'https://au.res.keymedia.com/files/image/emoji.jpg' }
    bye_week { rand(4..12) }
    ffn_id { rand(1000..9999) }
    projection_week { 8 }
    current_projection { 12.34 }
    injury_status { nil }
  end
end
