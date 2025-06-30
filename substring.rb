def substring(string, dictionary)
  substrings = Hash.new(0)
  string_arr = string.split(" ")
  dictionary.each_with_index do |dictionary_word, idx|
    string_arr.each do |string_word|
      dictionary_split = dictionary_word.split("")
      string_split = string_word.split("")
      common_characters = string_split.intersection(dictionary_split)
      if common_characters.join("") == dictionary_split.join("")
        substrings[dictionary[idx]] += 1
      end
    end
  end
  return substrings
end