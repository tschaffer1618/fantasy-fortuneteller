# Fantasy FortuneTeller

Fantasy FortuneTeller makes fantasy football easy! FF allows you to compare NFL players and their current weekly fantasy projections without being bombarded with unnecessary stats.

Please visit our production app [here](https://fantasy-fortuneteller.herokuapp.com/).

## How Does It Work?

FF makes use of a secondary Sinatra app (link [here](https://github.com/fentontaylor/fantasy_football_nerd_microservice)) that holds current NFL player data and projections from several external APIs (Fantasy Football Nerd, SportsData, and nflscrapR). Within FF, you can easily make teams and add players to those teams, allowing straightforward fantasy projection comparisons for the current NFL week.

## Getting Started

- Clone this repository
- CD into this repository
- Run `bundle`
- Run `rake db:{create,migrate,seed}`
- There are 4 rake tasks necessary to update the current player data (these tasks do require that you have a key to the FF Sinatra API- please contact one of the application authors for more information)
  - `rake import:players` to load all current NFL fantasy players into the db
  - `rake import:logos` to load NFL team logos
  - `rake update:injuries` to update current player injury statuses
  - `rake update:projections` to get the current week fantasy projections for each player

## Running the tests

To view the testing suite, please run `rspec` from the root directory `/fantasy-fortuneteller`

## Behind the Scenes

- Ruby 2.4.1
- Rails 5.2.3
- DB: PostgresQL
- CI: TravisCI
- Testing: RSpec
- External API calls: Faraday
- Background workers: Redis and Sidekiq
- User experience: HTML, CSS, and JavaScript
- Performance metrics: New Relic

## Authors

* **Fenton Taylor** - [Fenton Taylor](https://github.com/fentontaylor)

* **Alec Wells** - [alect47](https://github.com/alect47)

* **Tyler Schaffer** - [tschaffer1618](https://github.com/tschaffer1618)
