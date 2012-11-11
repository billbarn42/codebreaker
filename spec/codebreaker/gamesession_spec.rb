require 'spec_helper'

module Codebreaker
  describe GameSession do

    let (:gamesession)   { GameSession.new() }

    describe "#secret" do
      it "generates a secret" do
 #       output.should_receive(:puts).with(/\d{4}/)
        gamesession.secret.should match /\d{4}/
      end
    end
    
    describe "#turns" do
      it "returns a list of turns" do
        (1..4).each do 
          gamesession.takeTurn("1234")
        end

        gamesession.turns.length.should equal(4)
      end
    end
  end
end

