def read_input(filename = 'example_input')
  games = []

  File.open(filename, 'r') do |file|
    start_game = false
    button_a = []
    button_b = []
    prize_location = []

    file.each_line do |line|
      unless start_game
        start_game = true
        button_a = []
        button_b = []
        prize_location = []
      end

      line = line.strip

      if line.include?('Button A:')
        moving = line.split('Button A: ')[1].split(',')
        button_a = moving.map { |x| x.split('+')[1].to_i }
        next
      end

      if line.include?('Button B:')
        moving = line.split('Button B: ')[1].split(',')
        button_b = moving.map { |x| x.split('+')[1].to_i }
        next
      end

      if line.include?('Prize:')
        position = line.split('Prize: ')[1].split(',')
        prize_location = position.map { |x| x.split('=')[1].to_i }
        next
      end

      start_game = false

      games << { button_a: button_a, button_b: button_b, prize_location: prize_location }
    end

    if start_game
      games << { button_a: button_a, button_b: button_b, prize_location: prize_location }
    end
  end

  games
end
