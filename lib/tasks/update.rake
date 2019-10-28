require 'rake'
require 'rubygems'
require 'faraday'

namespace :update do
  desc 'Update player projections for current week'
  current_projections.each do |proj|    
    player = Player.find_by(ffn_id: proj[:ffn_id])
    Player.update(
      projection_week: proj[:week],
      current_projection:proj[:projection]
    )
  end
end

def current_projections
  response = Faraday.get "https://ff-nerd-service.herokuapp.com/projections/current?key=#{ENV['MY_FF_API_KEY']}"
  JSON.parse(response.body, symbolize_names: true)
end
