require 'codebreaker/gamesession'
require 'codebreaker/marker'

module Codebreaker
  class Game
    def initialize(input, output)
      @input = input
      # puts "initializing game, @input = #{@input.messages}"
      @output = output
    end
    def start(secret="")
      @session = GameSession.new(secret)
      # @output.puts("secret code is #{@secret}")
      @output.puts("Welcome to Codebreaker!")
      @output.puts("Enter guess:")
    end
    def go(turns)
      marker = ""
      (1..turns).each do | turn | 
        guess = @input.gets.chomp
        marker = takeTurn(guess)
        if @session.won? then
          @output.puts "Congratulations, you won!"
          reveal_secret
          break
        end
      end
      if !@session.won? then
        @output.puts "Sorry, you lost!"
        reveal_secret
      end
    end
    def secret
      @secret
    end
    def reveal_secret
      @output.puts "The secret code was #{@session.secret}"
    end
    def session
      @session
    end
    def takeTurn(guess)
      @output.puts @session.takeTurn(guess)
    end
  end
end