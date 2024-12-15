require 'rspec/autorun'
require './input_reader'
require './moving_robot'

describe '#moving_robot' do
  describe 'when robot is moving left' do
    it 'should not move any boxes' do
      robot, boxes, walls = read_input('mock/map1')
      instructions = ['left']

      result = moving_robot(robot, walls, boxes, instructions)

      expect(
        sort_box(result[:new_boxes])
      ).to eq(boxes)
    end
  end

  describe 'when robot is moving up' do
    it 'should not move any boxes' do
      robot, boxes, walls = read_input('mock/map1')
      instructions = ['up']

      result = moving_robot(robot, walls, boxes, instructions)

      expect(
        sort_box(result[:new_boxes])
      ).to eq(boxes)
    end
  end

  describe 'when robot is moving up then right' do
    it 'should move the box to the right' do
      robot, boxes, walls = read_input('mock/map1')
      instructions = %w[up right]

      result = moving_robot(robot, walls, boxes, instructions)

      expect(
        sort_box(result[:new_boxes])
      ).to eq([[1, 4], [1, 5], [2, 4], [3, 4], [4, 4], [5, 4]])
    end
  end

  describe 'when robot is moving up then double right' do
    it 'should move the box to the right twice' do
      robot, boxes, walls = read_input('mock/map1')
      instructions = %w[up right right]

      result = moving_robot(robot, walls, boxes, instructions)

      expect(
        sort_box(result[:new_boxes])
      ).to eq([[1, 5], [1, 6], [2, 4], [3, 4], [4, 4], [5, 4]])
    end
  end

  def sort_box(boxes)
    boxes.sort { |a, b| a[0] == b[0] ? a[1] <=> b[1] : a[0] <=> b[0] }
  end
end
