# frozen_string_literal: true

class Game
  def new_game
    computer_code = code_maker
    round = 1
    loop do
      human_code = code_breaker
      break if game_end?(human_code, computer_code) || round == 12

      round += 1
    end
  end

  def code_maker
    Array.new(4) { Random.rand(1..8).to_s }
  end

  def code_breaker
    puts 'Input your guessed code (1 ~ 8): '
    gets.chomp.split('')
  end

  def game_end?(human_code, computer_code)
    reds = 0
    human_code.each_with_index do |_code, idx|
      reds += 1 if human_code[idx] == computer_code[idx]
    end
    similarities = (human_code & computer_code).flat_map do |n|
      [n] * [human_code.count(n), computer_code.count(n)].min
    end
    whites = similarities.length - reds

    if reds == 4
      puts "You've won!! You've successfully cracked the code!!"
      puts "Your code: #{human_code} == Computer's code: #{computer_code}"
      return true
    end
    puts "Red pegs: #{reds}, White pegs: #{whites}"
    false
  end
end

Game.new.new_game
