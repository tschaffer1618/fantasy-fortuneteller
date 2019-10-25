require 'rake'
require 'faraday'
# require 'jbuilder'
# require 'csv'


namespace :import do
  desc 'Import from ff-nerd-service' do


    task players: :environment do
      json_response = Faraday.get 'https://ff-nerd-service.herokuapp.com/players'
        player_data = JSON.parse(json_response.body, symbolize_names: true)
    end
  end
end

# def players
#   json_response = Faraday.get 'https://ff-nerd-service.herokuapp.com/players'
#   player_data = JSON.parse(json_response.body, symbolize_names: true)
# end
