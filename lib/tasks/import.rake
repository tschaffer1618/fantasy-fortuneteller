require 'rake'
require 'rubygems'
require 'faraday'

namespace :import do
  desc 'Import from ff-nerd-service'

  task players: :environment do
    players
    binding.pry
      # json_response = Faraday.get 'https://ff-nerd-service.herokuapp.com/players'
      # player_data = JSON.parse(json_response.body, symbolize_names: true)
  end
end

def players
  json_response = Faraday.get 'https://ff-nerd-service.herokuapp.com/players'
  player_data = JSON.parse(json_response.body, symbolize_names: true)
end
