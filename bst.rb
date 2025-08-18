class Tree
  include Comparable
  attr_accessor :root

  def initialize(arr)
    self.root = build_tree(arr, 0, arr.length)
    return root
  end

  def build_tree(arr, start, finish)
    arr = arr.uniq.sort
    return nil if start >= finish || start >= arr.length

    mid = (start + finish) / 2
    root = Node.new(arr[mid])
    root.left = build_tree(arr, start, mid)
    root.right = build_tree(arr, mid + 1, finish)

    return root
  end

  def pretty_print(node = root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value, root=self.root)
    if root.nil?
      return Node.new(value)
    end
    if value == root.value
      puts 'value already in tree'
      return root
    elsif value < root.value
      root.left = insert(value, root.left)
    elsif value > root.value
      root.right = insert(value, root.right)
    end
    return root
  end

  def delete(value, root=self.root)
    return nil if root.nil?

    if root.value == value
      if root.left.nil? && root.right.nil?
        return nil
      elsif root.right.nil?
        return root.left
      elsif root.left.nil?
        return root.right
      else
        next_largest = root.right
        next_largest = next_largest.left while next_largest.left
        root.value = next_largest.value
        root.right = delete(next_largest.value, root.right)
        return root
      end
    else
        if root.value > value
          root.left = delete(value, root.left)
        elsif root.value < value
          root.right = delete(value, root.right)
        end
    end

    return root
  end

  def find(value, root=self.root)
    if root.nil?
      return "not found"
    end
    if root.value == value
      return root
    elsif root.value < value
      return find(value, root.right)
    else
      return find(value, root.left)
    end
  end

  def level_order
    if self.root.nil? then return end
    queue = []
    queue.append(self.root)
    while !queue.empty?
      removed_node = queue.shift
      yield(removed_node.value)
      if !removed_node.left.nil? then queue.append(removed_node.left) end
      if !removed_node.right.nil? then queue.append(removed_node.right) end
    end
  end

  def preorder(root=self.root, &block)
    if root.nil? then return end
    yield(root.value)
    preorder(root.left, &block)
    preorder(root.right, &block)
  end

  def inorder(root=self.root, &block)
    if root.nil? then return end
    inorder(root.left, &block)
    yield(root.value)
    inorder(root.right, &block)
  end

  def postorder(root=self.root, &block)
    if root.nil? then return end
    postorder(root.left, &block)
    postorder(root.right, &block)
    yield(root.value)
  end

  def height(value, root=self.root)
    if root.nil?
      return
    elsif root.value == value
      right_root, left_root = root, root
      right_height, left_height = 0, 0
      while !right_root.nil?
        right_root = right_root.right
        right_height += 1
      end
      while !left_root.nil?
        left_root = left_root.left
        left_height += 1
      end

      return [right_height, left_height].max - 1
    elsif root.value < value
      return height(value, root=root.right)
    else
      return height(value, root=root.left)
    end
  end

  def depth(value, root=self.root, count=0)
    if root.nil? then return end
    
    if root.value == value
      return count
    elsif root.value < value
      count += 1
      return depth(value, root.right, count)
    elsif root.value > value
      count += 1
      return depth(value, root.left, count)
    end
  end

  class Node
    attr_accessor :value, :left, :right

    def initialize(value)
      self.value = value
      self.left = nil
      self.right = nil
    end
  end
end

my_tree = Tree.new([1, 2, 3, 4, 5, 6, 7])
my_tree.pretty_print
p my_tree.depth(5)