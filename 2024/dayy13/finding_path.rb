def cheapest_tokens_to_win_prize(button_a, button_b, prize_location, limit)
  ax = button_a[0]
  ay = button_a[1]

  bx = button_b[0]
  by = button_b[1]

  px = prize_location[0]
  py = prize_location[1]

  ca = (px * by - py * bx).to_f / (ax * by - ay * bx)
  cb = (px - ax * ca).to_f / bx

  # Initialize total variable

  # Check if ca and cb are integers and within the specified range
  return 0 unless ca % 1 == 0 && cb % 1 == 0

  return 0 if limit && !(ca <= 100 && cb <= 100)

  (ca * 3 + cb).to_i
end
