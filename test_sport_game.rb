require "minitest/autorun"
require './sport_game'

describe SportGame do
  before do
    @sport_game = SportGame.new
  end

  describe "when load the file, we get each match" do
    it "should be able to read input" do
      _(@sport_game.load).wont_be_nil
    end

    it "can parses input as an array" do
      _(@sport_game.parse).must_be_kind_of(Array)
    end

    it "should rule out the match" do
      match = "Lions 3, Snakes 3"
      expected = {:lions => 3, :snakes => 3}

      _(@sport_game.rule(match)).must_equal(expected)
    end

    it "should rule out even with long team name from the match" do
      match = "Tarantulas 1, Fc Awesome 0"
      expected = {:tarantulas => 1, :fc_awesome => 0}

      _(@sport_game.rule(match)).must_equal(expected)
    end

    it "should tell the match result" do
      hashed_matches = [
        {:lions => 3, :snakes => 3},
        {:tarantulas => 1, :fc_awesome =>0},
        {:lions => 1, :fc_awesome => 1}
      ]
      expected = {:lions => 2, :snakes => 1, :taratulas => 3, :fc_awesome => 1}

      _(@sport_game.tell_result(hashed_matches)).must_equal(expected)
    end
  end
end
