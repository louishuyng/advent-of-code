require 'set'

def program(list_connected)
  hash_connected = parse_connected_to_hash(list_connected)

  puts "Hash connected: #{hash_connected}"

  largest_set = find_largest_set_connected_to_each_other(hash_connected)

  puts "Password: #{largest_set.sort.join(',')}"
end

def find_largest_set_connected_to_each_other(hash_connected)
  largest_set = []

  hash_connected.each do |node, _|
    set_nodes = find_set_connected_with_node(node, hash_connected, [node])

    largest_set = set_nodes if set_nodes.size > largest_set.size
  end

  largest_set
end

def find_set_connected_with_node(node, hash_connected, set_nodes = [], visited = Set.new)
  return 0 if visited.include?(node)

  visited.add(node)

  hash_connected[node].each do |connected_node|
    list_nodes = hash_connected[connected_node]

    next unless set_nodes.all? { |node| list_nodes.include?(node) }

    set_nodes = find_set_connected_with_node(
      connected_node,
      hash_connected,
      set_nodes + [connected_node],
      visited
    )
  end

  set_nodes
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
