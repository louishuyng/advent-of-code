def moving_bot(position, vector, titles, seconds)
  new_position = [position[0], position[1]]

  seconds.times do
    new_position = [new_position[0] + vector[0], new_position[1] + vector[1]]

    if new_position[0].negative?
      new_position[0] = titles[0] + new_position[0]
    elsif new_position[0] >= titles[0]
      new_position[0] = new_position[0] - titles[0]
    end

    if new_position[1].negative?
      new_position[1] = titles[1] + new_position[1]
    elsif new_position[1] >= titles[1]
      new_position[1] = new_position[1] - titles[1]
    end
  end

  new_position
end
