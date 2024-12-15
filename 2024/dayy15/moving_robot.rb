def moving_robot(robot, walls, boxes, instructions)
  new_boxes_position = boxes.dup
  start_robot = robot.dup

  instructions.each do |instruction|
    new_position_robot = moving_direction(start_robot, instruction)

    next if facing_wall?(new_position_robot, walls)

    unless facing_box?(new_position_robot, new_boxes_position)
      start_robot = new_position_robot
      next
    end

    moving_boxes = move_box_to_new_direction(
      new_position_robot, instruction, walls, new_boxes_position
    )

    next if moving_boxes.nil?

    # Delete the original position of the box
    moving_boxes.each do |moving_box|
      new_boxes_position.delete(moving_box[:original_position])
    end

    # Then add the new position of the box
    moving_boxes.each do |moving_box|
      new_boxes_position << moving_box[:new_position]
    end

    start_robot = new_position_robot
  end

  { new_boxes: new_boxes_position }
end

def move_box_to_new_direction(box, direction, walls, boxes)
  moving_boxes = []

  next_empty_space = find_next_empty_space(box, direction, walls, boxes)

  return nil if next_empty_space.nil?

  position = box.dup
  while position != next_empty_space
    moved_position = moving_direction(position, direction)
    moving_boxes << { original_position: position, new_position: moved_position }

    position = moved_position
  end

  moving_boxes
end

def find_next_empty_space(start, direction, walls, boxes)
  new_position = moving_direction(start, direction)

  return nil if facing_wall?(new_position, walls)

  return new_position unless facing_box?(new_position, boxes)

  find_next_empty_space(new_position, direction, walls, boxes)
end

def moving_direction(thing, direction)
  path = {
    up: [-1, 0],
    down: [1, 0],
    left: [0, -1],
    right: [0, 1]
  }[direction.to_sym]

  [thing[0] + path[0], thing[1] + path[1]]
end

def facing_wall?(robot, walls)
  walls.include?(robot)
end

def facing_box?(robot, boxes)
  boxes.include?(robot)
end
