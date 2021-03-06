class User < ApplicationRecord
  has_many :teams, dependent: :destroy
  validates_presence_of :user_name
  validates_presence_of :email

  enum role: { reg_user: 0, admin: 1 }

  def self.find_or_create_from_auth_hash(auth)
		where(provider: auth[:provider], uid: auth[:uid]).first_or_initialize.tap do |user|
			user.provider = auth[:provider]
			user.uid = auth[:uid]
			user.first_name = auth[:info][:first_name]
			user.last_name = auth[:info][:last_name]
			user.email = auth[:info][:email]
			user.user_name = auth[:info][:email].split("@").first
      user.google_token = auth[:credentials][:token]
      user.google_refresh_token = auth[:credentials][:refresh_token]
      user.google_oauth_expires_at = auth[:credentials][:expires_at]
			user.picture = auth[:info][:image]
			user.save
		end
	end

  def has_no_teams?
    self.teams.empty?
  end
end
