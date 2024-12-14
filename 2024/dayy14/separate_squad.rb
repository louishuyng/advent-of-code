def separate_squad(robots, titles)
  squad = []

  squad << find_top_left_squad(robots, titles)
  squad << find_top_right_squad(robots, titles)
  squad << find_bottom_left_squad(robots, titles)
  squad << find_bottom_right_squad(robots, titles)

  squad
end

def find_top_left_squad(robots, titles)
  left_horizontal_line = titles[0] / 2
  left_vertical_line = titles[1] / 2

  robots.select do |robot|
    robot[0] < left_horizontal_line && robot[1] < left_vertical_line
  end
end

def find_top_right_squad(robots, titles)
  right_horizontal_line = titles[0] / 2
  right_vertical_line = titles[1] / 2

  robots.select do |robot|
    robot[0] < right_horizontal_line && robot[1] > right_vertical_line
  end
end

def find_bottom_left_squad(robots, titles)
  left_horizontal_line = titles[0] / 2
  left_vertical_line = titles[1] / 2

  robots.select do |robot|
    robot[0] > left_horizontal_line && robot[1] < left_vertical_line
  end
end

def find_bottom_right_squad(robots, titles)
  right_horizontal_line = titles[0] / 2
  right_vertical_line = titles[1] / 2

  robots.select do |robot|
    robot[0] > right_horizontal_line && robot[1] > right_vertical_line
  end
end
