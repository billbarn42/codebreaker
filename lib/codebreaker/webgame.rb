require 'rubygems'
require 'sinatra'
require_relative 'gamesession'

enable :sessions

# require 'codebreaker/gamesession'

get '/hi' do
	"gotcha"
end
get '/codebreaker' do
	cb = Codebreaker::GameSession.new()
	secret = cb.secret
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
	@guess = params[:guess]
	@cb = session['cb']
	@cb.takeTurn(@guess)
	@turns = @cb.turns
	@secret = @cb.secret

	haml :guess
 
end