require 'rubygems'
require 'sinatra'
require_relative 'gamesession'

enable :sessions
# set :public_folder, File.dirname(__FILE__) + '/static'

# require 'codebreaker/gamesession'

GUESS_IMAGES = {
    '1' => 'img/Blue.png',
    '2' => 'img/Brown.png',
    '3' => 'img/Cyan.png',
    '4' => 'img/Green.png',
    '5' => 'img/Orange.png',
    '6' => 'img/Red.png',
    '+' => 'img/Black.png',
    '-' => 'img/Gray.png'
  }


get '/hi' do
	"gotcha"
end
get '/codebreaker' do
	cb = Codebreaker::GameSession.new()
	@secret = cb.secret
	session['cb'] = cb
	haml :newgame
end
get '/index' do
	haml :index
end
get '/about' do
	haml :about
end
post '/guess' do
	if !(params[:turns].to_s == "")
		session['turns'] = params[:turns]
	end
	@guess = params[:guess]
	@cb = session['cb']
	@cb.takeTurn(@guess)
	@turns = @cb.turns
	@secret = @cb.secret
	@pegs = GUESS_IMAGES
	case 
	when @turns.last[0] == "++++"  
	  @msg = "Congratulations, you won!"
	  haml :gameover
	when @turns.length >= session['turns'].to_i  
	  @msg = "Sorry, you lost!"
	  haml :gameover
    else 
	  haml :guess
	end
end