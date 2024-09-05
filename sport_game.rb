class Score
  attr_accessor :games

  def rule(match)
    regex = /([a-zA-Z\s]+)\s(\d+)/

    match.split(",")
      .filter { |team| regex.match?(team) }
      .map{ |t| regex.match(t.strip).captures }.to_h
      .transform_values(&:to_i)
  end

  def game_result(match)
    match.values.inject(&:-)
  end

  def result(match)
    result = game_result(match)
    case
    when result == 0
      match.transform_values! {|v| v = 1}
    when result < 0
      match[match.first.first] = 0
      match[match.to_a.last.first] = 3
    when result > 0
      match[match.first.first] = 3
      match[match.to_a.last.first] = 0
    end
    match
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
