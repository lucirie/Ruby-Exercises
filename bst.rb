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

  class Node
    attr_accessor :value, :left, :right

    def initialize(value)
      self.value = value
      self.left = nil
      self.right = nil
    end
  end
end

my_tree = Tree.new([5, 6, 7, 2, 3, 4, 1])
my_tree.pretty_print
puts("----")
my_tree.insert(8)
my_tree.pretty_print
puts("----")
my_tree.delete(8)
my_tree.pretty_print
