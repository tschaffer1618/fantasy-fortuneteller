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

    zipped = players.zip(current)

    all_match = zipped.all? { |elem| elem[0].ffn_id == elem[1][:ffn_id].to_i }
    raise 'Not all ids match' unless all_match

    zipped.each do |info|
      player = info[0]
      data = info[1]

      player.update(
        projection_week: data[:week],
        current_projection: data[:projection]
      )

      puts "Updated: #{player.display_name} - Week #{data[:week]}"
    end

    week = Player.maximum(:projection_week)

    Player.where("projection_week < #{week}").each do |player|
      puts "Updating with default: #{player.display_name} - Week #{week}"
      player.update(projection_week: week, current_projection: 0)
    end
  end
end
