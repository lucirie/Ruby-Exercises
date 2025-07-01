def stock_picker(array)
  profits = Hash.new(0)
  array.each_with_index do |buy, idx_buy|
    (idx_buy+1...array.length).each do |idx_sell|
      sell = array[idx_sell]
      profit = sell - buy
      profits["[#{idx_buy}, #{idx_sell}]"] = profit
    end
  end
  largest_profit = 0
  best_pair = ""
  profits.each do |stock_pair, profit|
    if profit > largest_profit
      largest_profit = profit
      best_pair = stock_pair
    end
  end
  puts profits
  puts largest_profit
  return best_pair
end

puts stock_picker([17,3,6,9,15,8,6,1,10])