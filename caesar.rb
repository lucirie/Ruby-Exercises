def caesar_cipher(string, key)
  string_arr = string.chars.map do |char|
    ascii = char.ord
    if ascii >= 65 and ascii <= 90
      char = ((ascii - 65 + key) % 26 + 65).chr
      char.chr
    elsif ascii >= 97 and ascii <= 122
      char = ((ascii - 97 + key) % 26 + 97).chr
    else
      char
    end
  end
  return string_arr.join("")
end

puts caesar_cipher("What a string!", 5) # => "Bmfy f xywnsl!"