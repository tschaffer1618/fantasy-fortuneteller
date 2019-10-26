class Player < ApplicationRecord
  has_many :team_players

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

end
