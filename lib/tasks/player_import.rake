# require 'faraday'
# require 'jbuilder'

def players
  json_response = Faraday.get 'https://ff-nerd-service.herokuapp.com/players'
  )
  player_data = JSON.parse(json_response.body, symbolize_names: true)
end
