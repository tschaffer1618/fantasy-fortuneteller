require 'rails_helper'

describe User, type: :model do
  describe "relationships" do
    it {should have_many :teams}
  end

  describe "validations" do
    it {should validate_presence_of :user_name}
    it {should validate_presence_of :email}
  end

  describe "dependencies" do
    it "destroys teams when a user is destroyed" do
      user = create(:user, user_name: "Test")
      player = create(:player)
      team = user.teams.create!(name: "Test team")
      team_player = team.team_players.create!(player: player)

      expect { user.destroy }.to change { Team.count }.by(-1)
    end
  end

  it "creates itself from an oauth hash" do
    auth = {
      provider: "google",
      uid: "104534628262753737066",
      info: {
        email: "alec@gmail.com",
        first_name: "Alec",
        last_name: "Wells"
      },
      credentials: {
        token: "abcdefg12345",
        refresh_token: "12345abcdefg",
        expires_at: DateTime.now
      }
    }
    User.find_or_create_from_auth_hash(auth)
    new_user = User.first

    expect(new_user.provider).to eq("google")
    expect(new_user.uid).to eq("104534628262753737066")
    expect(new_user.email).to eq("alec@gmail.com")
    expect(new_user.first_name).to eq("Alec")
    expect(new_user.last_name).to eq("Wells")
    expect(new_user.google_token).to eq("abcdefg12345")
    expect(new_user.google_refresh_token).to eq("12345abcdefg")
    # expect(new_user.google_oauth_expires_at).to eq(auth[:credentials][:expires_at])
  end

  it "updates itself from an oauth hash" do
    auth = {
      provider: "google",
      uid: "104534628262753737066",
      info: {
        email: "luke@gmail.com",
        first_name: "Luke",
        last_name: "Latack"
      },
      credentials: {
        token: "abcdefg12345",
        refresh_token: "12345abcdefg",
        expires_at: DateTime.now
      }
    }
    User.find_or_create_from_auth_hash(auth)
    updated_user = User.first

    expect(updated_user.provider).to eq("google")
    expect(updated_user.uid).to eq("104534628262753737066")
    expect(updated_user.email).to eq("luke@gmail.com")
    expect(updated_user.first_name).to eq("Luke")
    expect(updated_user.last_name).to eq("Latack")
    expect(updated_user.google_token).to eq("abcdefg12345")
    expect(updated_user.google_refresh_token).to eq("12345abcdefg")
    # expect(updated_user.google_oauth_expires_at).to eq(auth[:credentials][:expires_at])
  end

  describe 'instance methods' do
    it '#has_no_teams?' do
      new_user = User.create!(user_name: 'fft', email: 'test@test.com')

      expect(new_user.has_no_teams?).to be true

      team = new_user.teams.create

      expect(new_user.has_no_teams?).to be false
    end
  end

  describe "roles" do
    it "can be created as a default user" do
      regular_user = User.create!(role: 0, user_name: "Test", email: "test@test.com")

      expect(regular_user.role).to eq("reg_user")
    end

    it "can be created as an admin user" do
      admin_user = User.create!(role: 1, user_name: "Test", email: "test@test.com")

      expect(admin_user.role).to eq("admin")
    end
  end
end
