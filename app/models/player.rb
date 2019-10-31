class Player < ApplicationRecord
  has_many :team_players
  has_many :teams, through: :team_players

  def current_status
    if injury_status
      injury_status
    elsif bye_week == projection_week
      'Bye'
    else
      '✔'
    end
  end

  def self.search(search)
    if search
      players = where('lower(display_name) like ?', "%#{search.downcase}%")
      if players.empty?
        all
      else
        players
      end
    else
      all
    end
  end

  def self.search_position(position)
    if position == 'all'
      all
    else
      where(position: position)
    end
  end

end
