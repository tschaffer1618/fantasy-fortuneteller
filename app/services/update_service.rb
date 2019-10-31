class UpdateService
  def fetch(path)
    Faraday.get "https://ff-nerd-service.herokuapp.com/#{path}?key=#{ENV['MY_FF_API_KEY']}"
  end

  def update_backend_projections
    fetch('projections/update_all')
  end

  def get_current_projections
    response = fetch('projections/current')
    current = JSON.parse(response.body, symbolize_names: true)

    ids = current.map { |proj| proj[:ffn_id]}
    players = Player.where(ffn_id: ids).order(:ffn_id)
    player_count = players.count
    week = current.first[:week]

    players.each_with_index do |player, i|
      match = current.find { |data| data[:ffn_id].to_i == player.ffn_id }

      player.update(
        projection_week: match[:week],
        current_projection: match[:projection]
      )

      puts "#{i + 1}/#{player_count} - Updated Projection: #{player.display_name} (Week #{week})"
    end

    zero_players = Player.where("projection_week < #{week}")
    z_count = zero_players.count

    zero_players.each_with_index do |player, i|
      puts "#{i + 1}/#{z_count} - Updated with default: #{player.display_name} (Week #{week})"
      player.update(projection_week: week, current_projection: 0)
    end
  end
end
