class Player < ApplicationRecord
  has_many :team_players

  def self.search(search)
    if search
      where('lower(display_name) like ?', "%#{search.downcase}%")
    else
      all
    end
  end

end
