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

    total + cheapest_tokens_to_win_prize(button_a, button_b, prize_location)
  end

  puts "Total tokens: #{tokens}"
end

program
