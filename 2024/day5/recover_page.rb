def recover_page(page, print)
  result = []

  until page.empty?
    largest_number = find_largest_number(page, print)

    result << largest_number
    page.delete(largest_number)
  end

  result
end

def find_largest_number(page, print)
  page.each do |number|
    larger_than_every_other_number = page.all? do |other_number|
      if number == other_number || print[number][:after].include?(other_number)
        true
      else
        false
      end
    end

    return number if larger_than_every_other_number
  end
end
