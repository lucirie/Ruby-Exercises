def knight_moves(position, destination, queue=[], visited=[])

  # Checks all possible moves from location
  x, y = position
  queue.append([x+2, y+1], [x-2, y-1], [x+1, y+2], [x-1, y-2], [x-2, y+1], [x-1, y+2], [x+2, y-1], [x+1, y-2])
  queue = queue.select { |location| (0..7).cover?(location[0]) && (0..7).cover?(location[1]) && !visited.include?(location)}

  
end