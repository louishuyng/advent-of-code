def generate_secret_number(number, number_of_generations = 1)
  secret_number = number

  number_of_generations.times do
    # First step: Calculate the result of multiplying the secret number by 64. Then, mix this result into the secret number. Finally, prune the secret number.
    result_multiply = multiply(secret_number, 64)
    secret_number = mix(secret_number, result_multiply)
    secret_number = prune(secret_number)

    # Second step: Calculate the result of dividing the secret number by 32. Round the result down to the nearest integer. Then, mix this result into the secret number. Finally, prune the secret number.
    result_divided = (secret_number / 32).floor
    secret_number = mix(secret_number, result_divided)
    secret_number = prune(secret_number)

    # Third step: Calculate the result of multiplying the secret number by 2048. Then, mix this result into the secret number. Finally, prune the secret number.
    result_multiply = multiply(secret_number, 2048)
    secret_number = mix(secret_number, result_multiply)
    secret_number = prune(secret_number)
  end

  secret_number
end

def test
  expected = %w[15887950
                16495136
                527345
                704524
                1553684
                12683156
                11100544
                12249484
                7753432
                5908254]

  expected.length.times do |index|
    secret_number = generate_secret_number(123, index + 1)

    throw "Expected #{expected[index]} but got #{secret_number}" if secret_number.to_i != expected[index].to_i
  end

  throw "Expected 8685429 but got #{generate_secret_number(1, 2000)}" if generate_secret_number(1, 2000) != 8_685_429

  puts 'All tests passed'
end

# Bitwise XOR
def mix(number_one, number_two)
  number_one ^ number_two
end

# calculate the value of the number modulo 16777216.
def prune(number)
  number % 16_777_216
end

def multiply(number, factor)
  number * factor
end

def program
  list_secret_numbers = File.open('input').read.split("\n").map(&:to_i)

  result = list_secret_numbers.inject(0) do |acc, secret_number|
    acc += generate_secret_number(secret_number, 2000)
  end

  puts "The result is: #{result}"
end

test

program
