require 'set'

def program(list_connected)
  hash_connected = parse_connected_to_hash(list_connected)

  puts "Hash connected: #{hash_connected}"

  set_3_connected = create_set_3_connected_from_hash(hash_connected)
  puts "Set 3 connected: #{set_3_connected}"

  # Count only set 3 connected has name starts with 't'
  count = set_3_connected.select do |nodes|
    nodes.any? { |n| n.start_with?('t') }
  end

  puts "Count: #{count.length}"
end

def create_set_3_connected_from_hash(hash_connected)
  result = Set.new

  hash_connected.each do |node, connected_nodes|
    connected_nodes.each do |connected_node|
      hash_connected.select do |s_node, s_connected_nodes|
        next if s_node == node || s_node == connected_node

        if s_connected_nodes.include?(node) && s_connected_nodes.include?(connected_node)
          result.add([node, connected_node, s_node].sort)
        end
      end
    end
  end

  result
end

def parse_connected_to_hash(list_connected)
  hash = {}

  list_connected.each do |node_a, node_b|
    hash[node_a] ||= []
    hash[node_b] ||= []

    hash[node_a] << node_b
    hash[node_b] << node_a
  end

  hash
end

input = File.read('input').split("\n")

list_connected = input.map do |line|
  node_a, node_b = line.split('-')

  [node_a, node_b]
end

program(list_connected)
