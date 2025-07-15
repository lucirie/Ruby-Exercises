# frozen_string_literal: true

def bubble_sort(array)
  (1..4).each do |_|
    (0...array.length - 1).each do |idx|
      next unless array[idx] > array[idx + 1]

      previous_number = array[idx]
      array[idx] = array[idx + 1]
      array[idx + 1] = previous_number
    end
  end
  array
end

puts bubble_sort([4, 3, 78, 2, 0, 2])
