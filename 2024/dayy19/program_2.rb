class TowelSolver
  def initialize(patterns_str, designs)
    @patterns = patterns_str.split(', ').map(&:strip)
    @designs = designs
    @memo = {}
  end

  def count_all_arrangements
    total = 0
    @designs.each do |design|
      ways = count_ways_to_make(design)
      total += ways
    end
    total
  end

  private

  def count_ways_to_make(target, start_pos = 0)
    return 1 if start_pos >= target.length
    return @memo["#{target}:#{start_pos}"] if @memo.key?("#{target}:#{start_pos}")

    total_ways = 0
    @patterns.each do |pattern|
      next if start_pos + pattern.length > target.length
      next if target[start_pos, pattern.length] != pattern

      total_ways += count_ways_to_make(target, start_pos + pattern.length)
    end

    @memo["#{target}:#{start_pos}"] = total_ways
    total_ways
  end
end

# Parse input
input = File.read(ARGV[0])

patterns, *designs = input.split("\n").reject(&:empty?)
solver = TowelSolver.new(patterns, designs)
puts solver.count_all_arrangements
