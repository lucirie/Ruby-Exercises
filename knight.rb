def knight_moves(position, destination)

  # Initialize the queue and previously visited arrays
  queue, visited = [], []

  queue << [position]                                     

  while !queue.empty?
    # Checks all possible moves from location
    path = queue.shift
    current = path[-1]
    return path if current == destination

    x, y = current
    moves = [[x+2, y+1], [x-2, y-1], [x+1, y+2], [x-1, y-2], [x-2, y+1], [x-1, y+2], [x+2, y-1], [x+1, y-2]]
    moves = moves.select { |location| (0..7).cover?(location[0]) && (0..7).cover?(location[1]) && !visited.include?(location)}

    moves.each do |move|
      visited << move
      queue << (path + [move])
    end
  end
end

p knight_moves([0, 0], [5, 2])