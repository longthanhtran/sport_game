class Score
  attr_accessor :games

  TYPES = {:win => [3, 0], :lose => [0, 3], :draw => [1, 1]}

  def rule(match)
    regex = /([a-zA-Z\s]+)\s(\d+)/

    match.split(",")
      .filter { |team| regex.match?(team) }
      .map{ |t| regex.match(t.strip).captures }.to_h
      .transform_values(&:to_i)
  end

  def game_result(scores)
    scores.inject(&:-)
  end

  def result(match)
    result = game_result(match.values)
    return Hash[match.keys.zip(TYPES[:draw])] if result == 0
    return Hash[match.keys.zip(TYPES[:lose])] if result < 0
    Hash[match.keys.zip(TYPES[:win])]
  end

  def declares
    @games.map { |match| result(rule(match)) }
      .inject({}) { |source, target|
        source.merge(target) { |key, value_1, value_2|
          value_1 + value_2
        }
      }
  end
end

class SportGame
  attr_accessor :games

  def load(filename)
    @games = File.read(filename).split("\n")
  end

  def score
    scorer = Score.new
    scorer.games = @games
    scorer.declares
  end
end


def process(games = nil)
  sport_game = SportGame.new
  sport_game.load(ARGV.last) if games.is_a? Array
  sport_game.games = games if games.is_a? String

  sport_game.score.sort_by {|game, point|
    [-point, game]
  }.each.with_index(1) do |game, idx|
    point = game.last != 1 ? "pts" : "pt"
    puts "#{idx}. #{game.first}, #{game.last} #{point}"
  end
end

# Handle via STDIN (pipeline)
if data = (STDIN.tty?) ? nil : $stdin.read
  process(data)
end

# If the arguments provided
if ARGV.first == '-f' && ARGV.last
  process(ARGV)
end
