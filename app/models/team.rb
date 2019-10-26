class Team < ApplicationRecord
  belongs_to :user
  has_many :team_players, dependent: :destroy
  has_many :players, through: :team_players

  validates_presence_of :name

end
