require './input_reader'
require './find_all_combination'

def program
  tests, number_per_test = read_input

  total = tests.filter.with_index do |test, index|
    puts "Test: #{test}"
    puts "Numbers: #{number_per_test[index]}"

    result = combine_to_test?(test, number_per_test[index])
    puts "Can combine to test #{result}"
    puts '-------------------'

    result
  end.inject(:+)

  puts "Total: #{total}"
end

def combine_to_test?(test, numbers)
  start_number = numbers[0]

  all_combinations = find_all_combination(numbers.size - 1, %i[add multiply combine])

  all_combinations.each do |combination|
    result = start_number

    numbers[1..].each_with_index do |number, index|
      case combination[index]
      when :add
        result += number
      when :multiply
        result *= number
      when :combine
        result = (result.to_s + number.to_s).to_i
      end
    end

    return true if result == test
  end

  false
end

program
