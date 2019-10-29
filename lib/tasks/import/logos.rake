namespace :import do
  desc 'Import logos from microservice to update defense and players with missing photos'

  task logos: :environment do
    response = Faraday.get "https://ff-nerd-service.herokuapp.com/team_logos?key=#{ENV['MY_FF_API_KEY']}"
    logos = JSON.parse(response.body, symbolize_names: true)

    players = Player.where(photo_url: nil)
    player_count = players.count

    players.each_with_index do |player, i|
      match = logos.find { |logo| logo[:team] == player.team }

      player.update(photo_url: match[:team_logo]) if match
      puts "#{i + 1}/#{player_count} - Updated Photo: #{player.display_name}"
    end
  end
end
