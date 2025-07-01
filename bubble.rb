def bubble_sort(array)
  for i in 1..4
    (0...array.length-1).each do |idx|
      if array[idx] > array[idx+1]
        previous_number = array[idx]
        array[idx] = array[idx+1]
        array[idx+1] = previous_number
      end
    end
  end
  return array
end

puts bubble_sort([4,3,78,2,0,2])