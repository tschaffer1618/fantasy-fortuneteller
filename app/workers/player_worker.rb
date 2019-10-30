class PlayerWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    response = Faraday.get "https://ff-nerd-service.herokuapp.com/projections/current?key=#{ENV['MY_FF_API_KEY']}"
    current = JSON.parse(response.body, symbolize_names: true)

    ids = current.map { |proj| proj[:ffn_id]}
    players = Player.where(ffn_id: ids).order(:ffn_id)
    week = current.first[:week]

    players.each do |player|
      match = current.find { |data| data[:ffn_id].to_i == player.ffn_id }
      player.update(
        projection_week: match[:week],
        current_projection: match[:projection]
      )
    end

    zero_players = Player.where("projection_week < #{week}")

    zero_players.each do |player|
      player.update(projection_week: week, current_projection: 0)
    end
  end
end
