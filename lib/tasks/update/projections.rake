require 'rake'
require 'rubygems'
require 'faraday'

namespace :update do
  desc 'Update player info for current week'

  task projections: :environment do
    response = Faraday.get "https://ff-nerd-service.herokuapp.com/projections/current?key=#{ENV['MY_FF_API_KEY']}"
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
      puts "#{i + 1}/#{z_count} - Updated with default: #{player.display_name} - Week #{week}"
      player.update(projection_week: week, current_projection: 0)
    end
  end
end
