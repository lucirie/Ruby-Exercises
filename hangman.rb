# frozen_string_literal: true

require 'yaml'

class Game
  def initialize
    if File.zero?('/home/lucirie/document/Ruby-Exercises/serialization/save.yaml') == false
      print "Reload previous save? (yes/no)\n==> "
      if gets.chomp == 'yes'
        path = YAML.load_file('/home/lucirie/document/Ruby-Exercises/serialization/save.yaml')
        return reload(path[:user_arr], path[:word_arr], path[:lives])
      end
    end
    start_new
  end

  def reload(blank_arr, word_arr, lives)
    print "Welcome back!!\n\n"
    word = word_arr.join
    until blank_arr.include?('_') == false
      if lives.zero?
        puts 'You lose!! Lives over.'
        break
      end
      puts blank_arr.join(' ')
      blank_arr, lives = get_guess(blank_arr, word_arr, lives)
    end
    puts "Your guess: #{blank_arr.join(' ')}\nCorrect word: #{word}"
  end

  def start_new
    lives = 5
    word = pick_random
    blank_arr = Array.new(word.length, '_')
    until blank_arr.include?('_') == false
      if lives.zero?
        puts 'You lose!! Lives over.'
        break
      end
      puts blank_arr.join(' ')
      blank_arr, lives = get_guess(blank_arr, word.split(''), lives)
    end
    puts "Your guess: #{blank_arr.join(' ')}\nCorrect word: #{word}"
  end

  def pick_random
    word = File.readlines('/home/lucirie/document/Ruby-Exercises/serialization/words.txt').map do |word|
      word.chomp if word.chomp.length >= 5 && word.chomp.length <= 12
    end[Random.rand(9800)]

    return pick_random if word.nil? == true

    word
  end

  def get_guess(blank_arr, word_arr, lives)
    print "Make your guess: (Save type: \"save\") \n==> "
    guess = gets.chomp
    if guess == 'save'
      cache = {
        user_arr: blank_arr,
        word_arr: word_arr,
        lives: lives
      }
      file = File.new('/home/lucirie/document/Ruby-Exercises/serialization/save.yaml', 'w')
      file.write(YAML.dump(cache))
      file.close
      exit
    end
    guess = (guess.length == 1 ? guess : get_guess(blank_arr, word_arr, lives))
    if word_arr.include?(guess)
      word_arr.each_with_index do |letter, idx|
        next unless letter == guess

        lives += 1
        puts "Correct guess!! Lives: #{lives}"
        blank_arr[idx] = guess
      end
    else
      lives -= 1
      puts "Wrong guess.. Lives: #{lives}"
    end
    [blank_arr, lives]
  end
end

Game.new
