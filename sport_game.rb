class SportGame

  def load
    File.read('input.txt')
  end

  def parse
    load.split("\n")
  end

  def rule(match)
    regex = /([a-zA-Z\s]+)\s(\d+)/

    match.split(",").map {|t| regex.match(t).captures}.to_h
      .transform_keys{|k| k.strip.downcase.gsub(/\s/, "_").to_sym}
      .transform_values(&:to_i)
  end

  def tell_result(matches)

  end
end
