def generate_secret_number(initial_secret, generations = 2000)
  secret = initial_secret

  generations.times do
    secret = prune(mix(secret, multiply(secret, 64)))
    secret = prune(mix(secret, (secret / 32).floor))
    secret = prune(mix(secret, multiply(secret, 2048)))
  end

  secret
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
