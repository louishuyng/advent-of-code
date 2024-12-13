THRESH_BUTTON_PRESS = 1000 # Set a high threshold to prevent premature termination

def cheapest_tokens_to_win_prize(button_a, button_b, prize_location)
  # Initialize the queue for BFS: [current_position, tokens_spent]
  queue = [[0, 0]] # Start at position (0, 0) with 0 tokens spent
  visited = {} # HashSet to track visited positions

  until queue.empty?
    position, tokens_spent = queue.shift

    # Check if we've reached the prize location
    return tokens_spent if position == prize_location

    # Move using Button A
    new_position_a = [position[0] + button_a[0], position[1] + button_a[1]]
    new_tokens_a = tokens_spent + 3

    # Move using Button B
    new_position_b = [position[0] + button_b[0], position[1] + button_b[1]]
    new_tokens_b = tokens_spent + 1

    # Add new positions to the queue if not visited
    if !visited[new_position_a] && new_tokens_a <= THRESH_BUTTON_PRESS * 3
      queue << [new_position_a, new_tokens_a]
      visited[new_position_a] = true
    end

    if !visited[new_position_b] && new_tokens_b <= THRESH_BUTTON_PRESS
      queue << [new_position_b, new_tokens_b]
      visited[new_position_b] = true
    end
  end

  # If we exhaust all options without reaching the prize
  0 # Indicate failure to reach the prize
end
