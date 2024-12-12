def calculate_perimeter(points)
  perimeter = 0
  previous_row = nil

  # Get all unique rows from the points
  find_all_rows(points).each do |row|
    # Find continuous segments of points in the current row
    continuous_segments = find_row_points_continuously(points, row)

    continuous_segments.each do |segment|
      # Calculate the perimeter contribution of the current segment
      perimeter_segment = calculate_perimeter_per_segment(segment)
      perimeter += perimeter_segment

      # If this is not the first row, adjust the perimeter for shared edges
      next unless previous_row

      previous_points = points.select { |point| point[0] == previous_row }
      common_columns = find_number_of_common_column_between_segments(segment, previous_points)
      perimeter -= common_columns * 2 # Each shared edge contributes to both rows
    end

    previous_row = row # Update the previous row to the current one
  end

  perimeter
end

def find_all_rows(points)
  points.map { |point| point[0] }.uniq
end

def calculate_perimeter_per_segment(segment)
  # Each segment contributes its length * 2 for the sides + 2 for the top and bottom edges
  (segment.length * 2) + 2
end

# Find continuous points in a specified row
def find_row_points_continuously(points, row)
  row_points = points.select { |point| point[0] == row }

  # Sort the points by their column index and group continuous columns
  row_points.sort_by { |point| point[1] }
            .chunk_while { |point_one, point_two| point_one[1] + 1 == point_two[1] }
            .to_a
end

# Find the number of common columns between two segments of points
def find_number_of_common_column_between_segments(segment_one, segment_two)
  segment_one_columns = segment_one.map { |point| point[1] }
  segment_two_columns = segment_two.map { |point| point[1] }

  # Find common columns
  common_columns = segment_one_columns & segment_two_columns
  common_columns.length
end
