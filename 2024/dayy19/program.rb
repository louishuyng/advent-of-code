class TowelSolver
  def initialize(patterns_str, designs)
    @patterns = patterns_str.split(', ').map(&:strip)
    @designs = designs
    @memo = {}
  end

  def count_possible_designs
    @designs.count { |design| can_make_pattern?(design) }
  end

  private

  def can_make_pattern?(target, start_pos = 0)
    return true if start_pos >= target.length
    return @memo["#{target}:#{start_pos}"] if @memo.key?("#{target}:#{start_pos}")

    @patterns.each do |pattern|
      next if start_pos + pattern.length > target.length
      next if target[start_pos, pattern.length] != pattern

      if can_make_pattern?(target, start_pos + pattern.length)
        @memo["#{target}:#{start_pos}"] = true
        return true
      end
    end

    @memo["#{target}:#{start_pos}"] = false
    false
  end
end

# Parse input
input = File.read(ARGV[0])

patterns, *designs = input.split("\n").reject(&:empty?)
solver = TowelSolver.new(patterns, designs)
puts solver.count_possible_designs
