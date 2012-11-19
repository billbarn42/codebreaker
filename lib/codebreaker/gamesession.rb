require_relative 'marker'

module Codebreaker
  class GameSession
    def initialize(secret="")
      if secret == ""
        @secret = generate_secret_code
      else
        @secret = secret
      end
      @turns = Array.new()
    end
    def generate_secret_code
      options = %w[1 2 3 4 5 6]
      (1..4).map { options.delete_at(rand(options.length))}.join
    end
    def takeTurn(guess)
    	@lastMarker = Marker.new(@secret, guess)
    	@turns << [@lastMarker.to_s, guess, @turns.length+1]
    	@lastMarker.to_s
    end
    def turns
    	@turns
    end
    def secret
      @secret
    end
    def won?
    	if @lastMarker.to_s == "++++"
    		true
    	else
    		false
    	end
    end
  end 
end
