def exec(prog, reg)
    pc = 0
    output = []
  
    while pc <= prog.length - 2
      op = prog[pc]
      operand = prog[pc + 1]
      combo = operand < 4 ? operand : reg[operand - 4]
  
      case op
      when 0  # adv
        reg[0] /= 2 ** combo
      when 1  # bxl
        reg[1] ^= operand
      when 2  # bst
        reg[1] = combo % 8
      when 3  # jnz
        if reg[0] != 0
          pc = operand
          next
        end
      when 4  # bxc
        reg[1] ^= reg[2]
      when 5  # out
        output << (combo % 8).to_s
      when 6  # bdv
        reg[1] = reg[0] / (2 ** combo)
      when 7  # cdv
        reg[2] = reg[0] / (2 ** combo)
      end
  
      pc += 2
    end
  
    output
  end
  
  def solve(filename)
    input = File.read(filename).strip
    parts = input.split("\n\n")
    prog = parts[1].split(':')[1].strip.split(',').map(&:to_i)
    
    to_visit = [[prog.length, 0]]
  
    while (pos, a = to_visit.shift)
      (0..7).each do |i|
        n_a = a * 8 + i
        o = exec(prog, [n_a, 0, 0])
        
        if o.map(&:to_i) == prog[pos - 1..]
          to_visit.push([pos - 1, n_a])
          if o.length == prog.length
            return n_a
          end
        end
      end
    end
  end
  
  if __FILE__ == $0
    t0 = Time.now
    result = solve('input')
    puts "time used: #{Time.now - t0} seconds"
    puts "Final result: #{result}"
  end