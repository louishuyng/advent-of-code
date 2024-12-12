def calculate_side(points)
  side = 0
  previous_rows = []

  find_all_rows(points).each do |row|
    puts '===================='
    puts "Row: #{row}"
    # Find continuous segments of points in the current row
    continuous_segments = find_row_points_continuously(points, row)

    continuous_segments.each do |segment|
      puts "segment: #{segment}"
      puts "previous_rows: #{previous_rows}"

      side_segment = calculate_side_per_segment(segment)
      side += side_segment
      puts "Side: #{side}"

      next if previous_rows.empty?

      previous_rows.each do |previous_row|
        common_columns = find_number_of_common_side_between_segments(segment, previous_row)
        side -= common_columns
      end

      puts "Side After: #{side}"
    end

    previous_rows = continuous_segments
  end

  side
end

def find_all_rows(points)
  points.map { |point| point[0] }.uniq
end

def calculate_side_per_segment(_segment)
  4
end

def find_row_points_continuously(points, row)
  row_points = points.select { |point| point[0] == row }

  # Sort the points by their column index and group continuous columns
  row_points.sort_by { |point| point[1] }
            .chunk_while { |point_one, point_two| point_one[1] + 1 == point_two[1] }
            .to_a
end

def find_number_of_common_side_between_segments(segment_one, segment_two)
  segment_one_column = segment_one.map { |point| point[1] }
  segment_two_column = segment_two.map { |point| point[1] }

  has_left_common = segment_one_column.min == segment_two_column.min
  has_right_common = segment_one_column.max == segment_two_column.max

  has_top_common_segment_two_inside_segment_one = segment_two_column.all? do |column|
    segment_one_column.include?(column)
  end

  has_top_common_segment_one_inside_segment_two = segment_one_column.all? do |column|
    segment_two_column.include?(column)
  end

  has_segment_in_middle = !has_left_common && !has_right_common

  middle_common = if has_segment_in_middle
                    0
                  else
                    (has_top_common_segment_two_inside_segment_one ? 1 : 0) \
                      + (has_top_common_segment_one_inside_segment_two ? 1 : 0)
                  end

  (has_left_common ? 1 : 0) + (has_right_common ? 1 : 0) + middle_common
end
