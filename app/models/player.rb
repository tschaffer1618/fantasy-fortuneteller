class Player < ApplicationRecord
  has_many :team_players
  has_many :teams, through: :team_players

  # this method is really big, but I think I need all of it so it
  # doesn't error out when there are no players found
  # it also just returns all the players if there is a search, but no matches
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
