class Team < ApplicationRecord
  belongs_to :user
  has_many :team_players, dependent: :destroy
  has_many :players, through: :team_players

  validates_presence_of :name

  def active_team_players
    team_players.where(benched: false)
  end

  def total_projected_score
    active_team_players.joins(:player).sum(:current_projection)
  end

end
