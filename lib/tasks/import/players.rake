require 'rake'
require 'rubygems'
require 'faraday'

namespace :import do
  desc 'Import from ff-nerd-service'

  task players: :environment do
    player_count = player_data.count

    player_data.each_with_index do |pd, i|
      Player.create!(active: pd[:active], jersey: pd[:jersey], lname: pd[:lname],
        fname: pd[:fname], display_name: pd[:displayName], team: pd[:team],
        position: pd[:position], height: pd[:height], weight: pd[:weight],
        college: pd[:college], experience: pd[:experience], birth_date: pd[:birthDate],
        photo_url: pd[:photoUrl], bye_week: pd[:byeWeek], ffn_id: pd[:ffn_id]
      )
      puts "#{(i +1).to_s.rjust(4, ' ')}/#{player_count} - Created #{pd[:displayName]}"
    end
  end
end

def player_data
  json_response = Faraday.get "https://ff-nerd-service.herokuapp.com/players?key=#{ENV['MY_FF_API_KEY']}"
  JSON.parse(json_response.body, symbolize_names: true)
end
