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

    it "should rule out the overall" do
      expected = {
        "Tarantulas" => 6,
        "Lions"      => 5,
        "FC Awesome" => 1,
        "Snakes"     => 1,
        "Grouches"   => 0
      }

      _(@sport_game.score).must_equal(expected)
    end
  end
end
