require 'rails_helper'

describe User, type: :model do
  describe "relationships" do
    it {should have_many :teams}
  end

  describe "validations" do
    it {should validate_presence_of :user_name}
    it {should validate_presence_of :email}
  end

  it "creates itself from an oauth hash" do
    auth = {
      provider: "google",
      uid: "12345678910",
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
    expect(new_user.uid).to eq("12345678910")
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
      uid: "12345678910",
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
    expect(updated_user.uid).to eq("12345678910")
    expect(updated_user.email).to eq("luke@gmail.com")
    expect(updated_user.first_name).to eq("Luke")
    expect(updated_user.last_name).to eq("Latack")
    expect(updated_user.google_token).to eq("abcdefg12345")
    expect(updated_user.google_refresh_token).to eq("12345abcdefg")
    # expect(updated_user.google_oauth_expires_at).to eq(auth[:credentials][:expires_at])
  end

  it 'instance methods' do
    new_user = create(:user, user_name: 'fft')
    verified_user = create(:user, user_name: 'fft', verified: true)

    expect(new_user.verified?).to eq(false)
    expect(verified_user.verified?).to eq(true)
  end

  describe "roles" do
    it "can be created as a default user" do
      regular_user = User.create(role: 0)

      expect(regular_user.role).to eq("reg_user")
    end

    it "can be created as an admin user" do
      admin_user = User.create(role: 1)

      expect(admin_user.role).to eq("admin")
    end
  end
end
