def program
  order_rules, pages = read_input

  puts "Order Rules: #{order_rules}"
  puts "\n"
  puts "Pages: #{pages}"

  print = build_order_rule_hash(order_rules)
  puts "\n"
  puts "Print: #{print}"

  correct_pages = pages.select do |page|
    page_incorrect_order?(page, print)
  end

  puts "Correct Pages: #{correct_pages}"

  # Sum only middle element of the page
  total = correct_pages.inject(0) do |sum, page|
    sum + page[page.length / 2]
  end

  puts "Total: #{total}"
end

def read_input
  order_rules = []
  pages = []

  # filename = 'example_input'
  filename = 'input'

  File.open(filename, 'r') do |file|
    # If include | then first element and second element are separated by | and add to order_rules
    # Else add to pages
    file.each_line do |line|
      order_rules << line.split('|').map(&:strip).map(&:to_i) if line.include?('|')
      pages << line.split(',').map(&:strip).map(&:to_i) if line.include?(',')
    end
  end

  [order_rules, pages]
end

def page_incorrect_order?(page, print)
  for i in 1..(page.length - 1)
    current = page[i]

    # All the right element must not be before the current element
    for j in (i + 1)..(page.length - 1)
      return false if print[current][:before].include?(page[j])
    end

    # All the left element must not be after the current element
    for j in 0..(i - 1)
      return false if print[current][:after].include?(page[j])
    end
  end

  true
end

def build_order_rule_hash(order_rules)
  print = {}

  order_rules.each do |order|
    left = order[0]
    right = order[1]

    if print[left].nil?
      print[left] = {
        before: [],
        after: []
      }
    end

    if print[right].nil?
      print[right] = {
        before: [],
        after: []
      }
    end

    print[left][:after] << right
    print[right][:before] << left
  end

  print
end

program
