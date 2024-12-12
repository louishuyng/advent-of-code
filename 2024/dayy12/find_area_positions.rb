def find_area_positions(garden)
  areas = []

  garden.each_with_index do |row, row_index|
    row.each_with_index do |cell, cell_index|
      next unless cell != 0

      area = { name: cell, positions: [] }
      areas << area

      queue = [[row_index, cell_index]]

      until queue.empty?
        current_position = queue.pop
        current_row = current_position[0]
        current_cell = current_position[1]

        next unless garden[current_row][current_cell] == cell

        area[:positions] << current_position

        garden[current_row][current_cell] = 0

        queue << [current_row - 1, current_cell] if current_row.positive?
        queue << [current_row, current_cell - 1] if current_cell.positive?
        queue << [current_row + 1, current_cell] if current_row < garden.length - 1
        queue << [current_row, current_cell + 1] if current_cell < row.length - 1
      end
    end
  end

  areas
end
