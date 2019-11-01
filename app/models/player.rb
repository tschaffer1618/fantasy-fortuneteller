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

  def defense_photo_url
    defense = Player.find_by(team: self.team, position: 'DEF')
    defense.photo_url if defense
  end

  def current_team_player(team)
    team_players.find_by(team_id: team.id)
  end

  def weekly_projections_array(projections)
    weeks = (1..self.projection_week).to_a
    weeks.map do |week_number|
      if projections.select{ |proj| proj[:week] == week_number }.empty?
        [week_number, 0.0]
      else
        projection = projections.select{ |proj| proj[:week] == week_number }.first
        [week_number, projection[:projection]]
      end
    end
  end

  def total_year_projection(projections)
    projections.sum do |proj|
      proj[:projection]
    end
  end
end
