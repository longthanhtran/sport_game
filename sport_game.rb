class SportGame
  attr_reader :games

  def load(filename)
    @games = File.read(filename)
  end

  def parse
    @games.split("\n")
  end

  def rule(match)
    regex = /([a-zA-Z\s]+)\s(\d+)/

    match.split(",")
      .map{ |t| regex.match(t).captures }.to_h
      .transform_keys{ |k| k.strip }
      .transform_values(&:to_i)
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

  def game_result(match)
    match.values.inject(&:-)
  end

  def declares
    parse.map { |match| result(rule(match)) }
      .inject({}) { |source, target|
        source.merge(target) { |key, value_1, value_2|
          value_1 + value_2
        }
      }
  end
end

if ARGV.first == '-f'
  sport_game = SportGame.new
  games = sport_game.load(ARGV.last)
  sport_game.declares.sort_by {|game, point|
    -point
  }.each.with_index(1) do |game, idx|
    point = game.last > 1 ? "pts" : "pt"
    puts "#{idx}. #{game.first}, #{game.last} #{point}"
  end
end

