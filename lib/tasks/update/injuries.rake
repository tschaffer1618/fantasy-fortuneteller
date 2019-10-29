require 'rake'
require 'rubygems'
require 'faraday'

namespace :update do
  desc 'Updates players with most recent injury reports'

  task injuries: :environment do
    response = Faraday.get "https://ff-nerd-service.herokuapp.com/injuries?key=#{ENV['MY_FF_API_KEY']}"
    injuries = JSON.parse(response.body, symbolize_names: true)

    ids = injuries.map { |proj| proj[:playerId]}
    players = Player.where(ffn_id: ids).order(:ffn_id)
    player_count = players.count
    week = injuries.first[:week]

    players.each_with_index do |player, i|
      match = injuries.find { |data| data[:playerId].to_i == player.ffn_id }

      status = "(#{match[:injury]}) #{match[:gameStatus]}"
      player.update(injury_status: status)

      puts "#{i + 1}/#{player_count} - Updated Injury: #{player.display_name} (Week #{week})"
    end

    healthy = Player.where.not(ffn_id: ids, injury_status: nil)
    h_count = healthy.count

    healthy.each_with_index do |player, i|
      puts "#{i + 1}/#{h_count} - Resetting Injury Status: #{player.display_name} - Week #{week}"
      player.update(injury_status: nil)
    end
  end
end
