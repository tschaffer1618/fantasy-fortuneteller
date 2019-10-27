# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Team.destroy_all
User.destroy_all

franky = User.create(
      provider: "google",
      uid: "104534628262753737066",
      email: "frankyfantasy123@gmail.com",
      first_name: "Franky",
      last_name: "Fantasy",
      user_name: "frankyfantasy123",
      google_token: "ya29.Il-pB1vlimKvZYI1OQ0R98OU2su2h6uEdIdYNoppXL-Gl0Cf1UQTgRi6OTLtCrfL4yqsDVfBM0kPmUiXYC_lgkhOZR1a_Ti4GkI-9nJoFJLdL47rYuvDfS9rlY_auo4MeA",
      google_refresh_token: "1//04MsYpwWLx9NwCgYIARAAGAQSNwF-L9IrnjsPI6Rl-zsxsVSyk2d9iK_KtyTm-XAasHKS5ylogCZjRHGkgDkyuO6utb2bSY4CoOg",
      picture: "https://lh5.googleusercontent.com/-H5cNmk8qov8/AAAAAAAAAAI/AAAAAAAAAAA/ACHi3re7tOJFcUitfEtjGRC5B_yj0b2Mg/s50-c/photo.jpg",
      verified: true,
      google_oauth_expires_at: nil,
      role: 0
    )

fiona = User.create(
      provider: "google",
      uid: "100422315769733903291",
      email: "fionafootballs123@gmail.com",
      first_name: "Fiona",
      last_name: "Footballs",
      user_name: "fionafootballs123",
      google_token: "ya29.Il-pB-qhhAMZcAgrDSm_RA6CsF_Yb_NRDUWfNsN5F0VUSk2ppKXOuay5L04S7cqLPUu6pH1pfDX-bDeeAXPg36uHbNPJYCiesksxDglwN53NQh4W6P8-YsLzoiIcCGnRFA",
      google_refresh_token: "1//04_RphUhD_4QjCgYIARAAGAQSNwF-L9Ir_DFfEV7ysyWx3DCpg5EueX6F3BGXcNrZNdsdNPBZn4cU4Ks-w_JvtitXYL_gTwA_dok",
      picture: "https://lh5.googleusercontent.com/-uPuWEQbz1yI/AAAAAAAAAAI/AAAAAAAAAAA/ACHi3reYTDMU2MMjn-dPDapSf-j1GcxM0g/s50-c/photo.jpg",
      verified: true,
      google_oauth_expires_at: nil,
      role: 1
    )

team_1 = franky.teams.create(name: "Oh Saquon You See?")
