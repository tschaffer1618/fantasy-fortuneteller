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

    zipped.each do |info|
      player = info[0]
      data = info[1]

      player.update(
        projection_week: data[:week],
        current_projection: data[:projection]
      )

      puts "Updated: #{player.display_name} - Week #{data[:week]}"
    end





    # current.each do |proj|
    #   week = proj[:week]
    #   player = Player.find_by(ffn_id: proj[:ffn_id])
    #   Player.update(
    #     projection_week: week,
    #     current_projection: proj[:projection]
    #   )
    #   puts "Updated: #{player.display_name} - Week #{week}"
    # end

    week = Player.maximum(:projection_week)

    Player.where("week < #{week}").each do |player|
      player.update(week: week, projection: 0)
      puts "Updated with default: #{player.display_name} - Week #{week}"
    end
  end
end
