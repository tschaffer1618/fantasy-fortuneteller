namespace :import do
  desc 'Import logos from microservice to update defense and players with missing photos'

  task logos: :environment do
    response = Faraday.get "https://ff-nerd-service.herokuapp.com/team_logos?key=#{ENV['MY_FF_API_KEY']}"
    logos = JSON.parse(response.body, symbolize_names: true)

    players = Player.where(photo_url: nil)

    players.each_with_index do |player|
      match = player
    end
  end
end
