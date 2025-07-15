def fib(n)
  arr = Arr.new(n-1)
  arr[0], arr[1] = 0, 1
  for i in 2..n-1
    arr[i] = arr[i-1] + arr[i-2]
  end
  return arr
end

def fib_rec(n)
  if n <= 1
    return n
  end
  return fib_rec(n-1) + fib_rec(n-2)
end

def merge_sort(arr)
  if arr.length > 1
    half = (arr.length/2).round
    left_half = arr[0...half]
    right_half = arr[half..-1]

    # Sort
    left_half = merge_sort(left_half)
    right_half = merge_sort(right_half)

    # Merge
    i = 0 # left_half index
    j = 0 # right_half index
    k = 0 # merged array index

    while i < left_half.length && j < right_half.length
      if left_half[i] <= right_half[j]
        arr[k] = left_half[i]
        i += 1
      else
        arr[k] = right_half[j]
        j += 1
      end
      k += 1
    end

    while i < left_half.length
      arr[k] = left_half[i]
      i += 1
      k += 1
    end

    while j < right_half.length
      arr[k] = right_half[j]
      j += 1
      k += 1
    end
  end
  return arr
end

p merge_sort([5, 4, 6, 3, 2, 1])