def read_input
  # filename = 'example_input'
  filename = 'input'

  test = []
  number_per_test = []

  File.open(filename, 'r') do |file|
    file.each_line do |line|
      split = line.split(':')
      test << split[0].to_i
      number_per_test << split[1].split(' ').map(&:to_i)
    end
  end

  [test, number_per_test]
end
