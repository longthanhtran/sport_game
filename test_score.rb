require "minitest/autorun"
require './sport_game'

describe Score do
  before do
    @scorer = Score.new
  end

  describe "scorer should handle several tasks" do
    it "should drop malform lines from final result" do
      match = "Lions: 3, Snakes; 3"
      expected = {}

      _(@scorer.rule(match)).must_equal(expected)
    end

    it "should rule out the match" do
      match = "Lions 3, Snakes 3"
      expected = {"Lions" => 3, "Snakes" => 3}

      _(@scorer.rule(match)).must_equal(expected)
    end

    it "should rule out even with long team name from the match" do
      match = "Tarantulas 1, FC Awesome 0"
      expected = {"Tarantulas" => 1, "FC Awesome" => 0}

      _(@scorer.rule(match)).must_equal(expected)
    end

    it "should tell a win match" do
      hashed_matches = {"Lions" => 3, "Snakes" => 1}
      expected = {"Lions" => 3, "Snakes" => 0}

      _(@scorer.result(hashed_matches)).must_equal(expected)
    end

    it "should tell a draw match" do
      hashed_matches = {"Lions" => 3, "Snakes" => 3}
      expected = {"Lions" => 1, "Snakes" => 1}

      _(@scorer.result(hashed_matches)).must_equal(expected)
    end

    it "should tell a lose match" do
      hashed_matches = {"Lions" => 1, "Snakes" => 3}
      expected = {"Lions" => 0, "Snakes" => 3}

      _(@scorer.result(hashed_matches)).must_equal(expected)
    end
  end
end
