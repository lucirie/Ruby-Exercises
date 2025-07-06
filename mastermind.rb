class Game
  def new_game()
    computer_code = self.code_maker()
    round = 1
    loop do
      human_code = self.code_breaker()
      break if self.game_end?(human_code, computer_code) || round == 12
      round += 1
    end
  end

  def code_maker()
    return Array.new(4) { Random.rand(1..8).to_s }
  end

  def code_breaker()
    puts "Input your guessed code (1 ~ 8): "
    human_code = gets.chomp.split('')
    return human_code
  end

  def game_end?(human_code, computer_code)
    reds = 0
    human_code.each_with_index do |code, idx|
      if human_code[idx] == computer_code[idx]
        reds += 1
      end
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
    return false
  end
end

Game.new.new_game()