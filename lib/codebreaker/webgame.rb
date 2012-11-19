require 'rubygems'
require 'sinatra'
require_relative 'gamesession'

enable :sessions
# set :public_folder, File.dirname(__FILE__) + '/static'

# require 'codebreaker/gamesession'

get '/hi' do
	"gotcha"
end
get '/codebreaker' do
	cb = Codebreaker::GameSession.new()
	@secret = cb.secret
	session['cb'] = cb
	haml :start
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