require "sinatra"
require_relative "game"
require'pry'

use Rack::Session::Cookie, {
  secret: "keep_it_secret_keep_it_safe"
}


get '/new' do

    session[:computer_result] = 0
    session[:player_result] = 0
    session[:visit_count] = 0
    session[:recent_result] = ["Please click a button to play!"]
    session[:start_over] = ""

  @game = RockPaperScissors.new

  erb :index
end

get '/new/game' do

  if session[:computer_result].nil?
    session[:computer_result] = 0
  end

  if session[:player_result].nil?
    session[:player_result] = 0
  end

  if session[:visitor_count].nil?
    session[:visit_count] = 1
  else
    session[:visit_count] += 1
  end

@game = RockPaperScissors.new(params)
erb :index

end

post '/new/game' do
  @game = RockPaperScissors.new(params)
  @game.play
  session[:recent_result] = @game.game_status

  if session[:recent_result][-1] == "Computer wins the round."
    session[:computer_result] += 1
  elsif session[:recent_result][-1] == "Player wins the round."
    session[:player_result] += 1
  end

  if session[:computer_result] >= 2
    session[:recent_result][-1] = "Computer wins the game!!!"
    session[:start_over] = "Click here to start over."
  elsif session[:player_result] >= 2
    session[:recent_result][-1] = "Player wins the game!!!"
    session[:start_over] = "Click here to start over."
  end

  redirect '/new/game'
end
