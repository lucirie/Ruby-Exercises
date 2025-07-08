require 'yaml'

class Game
  def initialize
    if File.zero?("/home/lucirie/document/Ruby-Exercises/serialization/save.yaml") == false
      print "Reload previous save? (yes/no)\n==> "
      if gets.chomp == "yes"
        path = YAML.load_file("/home/lucirie/document/Ruby-Exercises/serialization/save.yaml")
        return self.reload(path[:user_arr], path[:word_arr], path[:lives])
      end
    end
    return start_new
  end
  def reload(blank_arr, word_arr, lives)
    print "Welcome back!!\n\n"
    word = word_arr.join
    until blank_arr.include?("_") == false
      if lives == 0
        puts "You lose!! Lives over."
        break
      end
      puts blank_arr.join(" ")
      blank_arr, lives = self.get_guess(blank_arr, word_arr, lives)
    end
    puts "Your guess: #{blank_arr.join(" ")}\nCorrect word: #{word}"
  end

  def start_new
    lives = 5
    word = self.pick_random
    blank_arr = Array.new(word.length, "_")
    until blank_arr.include?("_") == false
      if lives == 0
        puts "You lose!! Lives over."
        break
      end
      puts blank_arr.join(" ")
      blank_arr, lives = self.get_guess(blank_arr, word.split(""), lives)
    end
    puts "Your guess: #{blank_arr.join(" ")}\nCorrect word: #{word}"
  end

  def pick_random
    word = File.readlines("/home/lucirie/document/Ruby-Exercises/serialization/words.txt").map { |word| 
      if word.chomp.length >= 5 && word.chomp.length <= 12
        word.chomp
      end
    }[Random.rand(9800)]

    if word.nil? == true
      return self.pick_random
    end
    return word
  end

  def get_guess(blank_arr, word_arr, lives)
    print "Make your guess: (Save type: \"save\") \n==> "
    guess = gets.chomp
    if guess == "save"
      cache = {
        user_arr: blank_arr,
        word_arr: word_arr,
        lives: lives
      }
      file = File.new("/home/lucirie/document/Ruby-Exercises/serialization/save.yaml", "w")
      file.write(YAML.dump(cache))
      file.close
      exit
    end
    guess = (guess.length == 1 ? guess : get_guess(blank_arr, word_arr, lives))
    if word_arr.include?(guess)
      word_arr.each_with_index do |letter, idx|
        if letter == guess
          lives += 1
          puts "Correct guess!! Lives: #{lives}"
          blank_arr[idx] = guess
        end
      end
      return blank_arr, lives
    else
      lives -= 1
      puts "Wrong guess.. Lives: #{lives}"
      return blank_arr, lives
    end
  end
end

Game.new