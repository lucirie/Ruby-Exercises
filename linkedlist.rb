class LinkedList
  attr_accessor :head

  def initialize
    self.head = nil
  end

  def append(value)
    if self.head.nil?
      self.head = Node.new(value, nil)
    else
      lastNode = self.head
      while !lastNode.nextNode.nil?
        lastNode = lastNode.nextNode
      end
      # We are at the end of the next
      lastNode.nextNode = Node.new(value, nil)
    end
  end

  def prepend(value)
    firstNode = self.head
    self.head = Node.new(value, firstNode)
  end

  def size
    count = 0
    currentNode = self.head
    while !currentNode.nil?
      count += 1
      currentNode = currentNode.nextNode
    end
    return count
  end


  def tail
    lastNode = self.head
    while !lastNode.nextNode.nil?
      lastNode = lastNode.nextNode
    end
    return lastNode
  end

  def at(index)
    currentNode = self.head
    current_idx = 0
    while !currentNode.nil?
      if current_idx == index
        return currentNode
      else
        current_idx += 1
        currentNode = currentNode.nextNode
      end
    end
    return nil
  end

  def pop
    lastNode = self.head
    while !lastNode.nextNode.nextNode.nil?
      lastNode = lastNode.nextNode
    end
    lastNode.nextNode = nil
  end

  def contains?(value)
    currentNode = self.head
    while !currentNode.nil?
      if currentNode.value == value
        return true
      else
        currentNode = currentNode.nextNode
      end
    end
    return false
  end
  
  def find(value)
    currentNode = self.head
    idx = 0
    while !currentNode.nil?
      if currentNode.value == value
        return idx
      else
        idx += 1
        currentNode = currentNode.nextNode
      end
    end
    return nil
  end

  def to_s
    list_arr = []
    list_string = ""
    currentNode = self.head
    while !currentNode.nil?
      list_arr.append(currentNode.value)
      currentNode = currentNode.nextNode
    end
    list_arr.each do |value|
      list_string += "(#{value}) -> "
    end
    list_string += "nil"
    return list_string
  end

  def insert_at(value, index)
    inserted_node = Node.new(value, self.at(index))
    self.at(index-1).nextNode = inserted_node
  end

  def remove_at(index)
    list_size = self.size-1
    if index < 0 || index > list_size
      return nil
    elsif index == 0
      self.head = self.head.nextNode
    elsif index == list_size
      self.at(list_size-1).nextNode = nil
    else
      self.at(index-1).nextNode = self.at(index+1)
    end
  end

  private

  class Node
    attr_accessor :value, :nextNode

    def initialize(value, nextNode)
      self.value = value
      self.nextNode = nextNode
    end
  end
end