# frozen_string_literal: true

class Game
  def new_game
    table = [[1, 2, 3],
             [4, 5, 6],
             [7, 8, 9]]

    until game_end?(table)
      table.each_with_index do |row, i|
        puts row.map(&:to_s).join(' | ')
        puts '--+---+--' unless i == table.size - 1
      end

      table = human(table)
      break if game_end?(table)

      table = computer(table)
    end
  end

  def computer(current_table)
    move = Random.rand(1..9)
    i = (move - 1) / 3
    j = (move - 1) % 3
    if current_table[i][j].is_a?(Integer)
      current_table[i][j] = 'O'
      current_table
    else
      computer(current_table)
    end
  end

  def human(current_table)
    puts 'Select your move: '
    move = gets.chomp.to_i

    i = (move - 1) / 3
    j = (move - 1) % 3
    if current_table[i][j].is_a?(Integer)
      current_table[i][j] = 'X'
      current_table
    else
      human(current_table)
    end
  end

  def game_end?(current_table)
    current_table.each do |row|
      next unless row[0] == row[1] && row[1] == row[2]

      if row[0] == 'X'
        puts 'You win!! Horizontal Win!!'
      else
        puts 'You lose.. Computer wins Horizontally.'
      end
      return true
    end

    (0..2).each do |i|
      next unless current_table[0][i] == current_table[1][i] && current_table[1][i] == current_table[2][i]

      if current_table[0][i] == 'X'
        puts 'You win!! Vertical Win!!'
      else
        puts 'You lose.. Computer wins Vertically.'
      end
      return true
    end

    if current_table[0][0] == current_table[1][1] && current_table[1][1] == current_table[2][2]
      if current_table[0][0] == 'X'
        puts 'You win!! Oblique Win!!'
      else
        puts 'You lose.. Computer wins in Oblique.'
      end
      return true
    end

    if current_table[0][2] == current_table[1][1] && current_table[1][1] == current_table[2][0]
      if current_table[0][2] == 'X'
        puts 'You win!! Oblique Win!!'
      else
        puts 'You lose.. Computer wins in Oblique.'
      end
      return true
    end

    if current_table.flatten.none? { |cell| cell.is_a?(Integer) }
      puts 'Tie!! No more space.'
      return true
    end

    false
  end
end

Game.new.new_game
