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

    zipped = players.zip(injuries)

    all_match = zipped.all? { |elem| elem[0].ffn_id == elem[1][:ffn_id].to_i }
    raise 'Not all ids match' unless all_match

    zipped.each do |info|
      player = info[0]
      player = info[1]

      player.update(injury_status)
    end
  end
end
