require './input_reader'
require './finding_path'

def program
  games = read_input('input')

  puts "Games count: #{games.count}"

  count = 0
  tokens = games.inject(0) do |total, game|
    puts "Processing game #{count}"
    count += 1

    button_a = game[:button_a]
    button_b = game[:button_b]
    prize_location = game[:prize_location]
    prize_location = [prize_location[0] + 10_000_000_000_000, prize_location[1] + 10_000_000_000_000]

    total + cheapest_tokens_to_win_prize(
      button_a,
      button_b,
      prize_location,
      nil
    )
  end

  puts "Total tokens: #{tokens}"
end

program
