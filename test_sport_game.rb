require "minitest/autorun"
require './sport_game'

describe SportGame do
  before do
    @sport_game = SportGame.new
    @sport_game.load('input.txt')
  end

  describe "when load the file, we get each match" do
    it "should be able to read input" do
      _(@sport_game.games).wont_be_nil
    end

    it "can parses input as an array" do
      _(@sport_game.parse).must_be_kind_of(Array)
    end

    it "should rule out the overall" do
      matches = [
        {"Lions": 3,      "Snakes": 3},
        {"Tarantulas": 1, "FC Awesome": 0},
        {"Lions": 1,      "FC Awesome": 1},
        {"Tarantulas": 3, "Snakes": 1},
        {"Lions": 4,      "Grouches": 0},
      ]
      expected = {
        "Tarantulas" => 6,
        "Lions"      => 5,
        "FC Awesome" => 1,
        "Snakes"     => 1,
        "Grouches"   => 0
      }

      _(@sport_game.declares).must_equal(expected)
    end

    it "should drop malform lines from final result" do
      match = "Lions: 3, Snakes; 3"
      expected = {}

      _(@sport_game.rule(match)).must_equal(expected)
    end

    it "should rule out the match" do
      match = "Lions 3, Snakes 3"
      expected = {"Lions" => 3, "Snakes" => 3}

      _(@sport_game.rule(match)).must_equal(expected)
    end

    it "should rule out even with long team name from the match" do
      match = "Tarantulas 1, FC Awesome 0"
      expected = {"Tarantulas" => 1, "FC Awesome" => 0}

      _(@sport_game.rule(match)).must_equal(expected)
    end

    it "should tell a win match" do
      hashed_matches = {"Lions" => 3, "Snakes" => 1}
      expected = {"Lions" => 3, "Snakes" => 0}

      _(@sport_game.result(hashed_matches)).must_equal(expected)
    end

    it "should tell a draw match" do
      hashed_matches = {"Lions" => 3, "Snakes" => 3}
      expected = {"Lions" => 1, "Snakes" => 1}

      _(@sport_game.result(hashed_matches)).must_equal(expected)
    end

    it "should tell a lose match" do
      hashed_matches = {"Lions" => 1, "Snakes" => 3}
      expected = {"Lions" => 0, "Snakes" => 3}

      _(@sport_game.result(hashed_matches)).must_equal(expected)
    end
  end
end
