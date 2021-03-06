#!/usr/bin/env ruby
# rubocop:disable Metrics/BlockNesting

require_relative '../lib/logic.rb'
require_relative '../lib/display.rb'
tictactoe = GameLogic.new
displaying_board = DisplayBoard.new(tictactoe.pmoves)

puts 'WELCOME TO TIC TAC TOE'
puts 'Main menu.'
puts '--------------'
puts '1. New game'
puts 'Type exit to leave game'

input = gets.chomp.to_s.upcase
exit if input == 'exit'

puts 'Choose your position using the following scheme'
puts '  1 | 2 | 3 '
puts '  4 | 5 | 6 '
puts "  7 | 8 | 9 \n\n\n"

until %w[EXIT N NO].include? input
  tictactoe.winner = -1

  if tictactoe.names_empty?
    puts 'Player 1. Enter your name'
    tictactoe.players[0] = gets.chomp
    puts 'Player 2. Enter your name'
    tictactoe.players[1] = gets.chomp
  end

  while tictactoe.winner == -1
    tictactoe.players.each_with_index do |name, index|
      pinput = nil
      while pinput.nil? && tictactoe.winner == -1
        puts "#{name}, #{tictactoe.pmoves[index]} please enter your move: "
        pinput = gets.chomp

        if pinput != 'exit'

          pinput = pinput.to_i
          if tictactoe.allowed_move?(pinput, name) && tictactoe.not_occupied_move?(pinput, name)
            tictactoe.store_move(index)
          else
            pinput = nil
          end

          puts tictactoe.invalid_move_messages
          tictactoe.check_win(index)
          tictactoe.check_draw unless tictactoe.winner >= 0
          puts displaying_board.print_board(tictactoe.pmoves)
        end
        tictactoe.winner = -3 if pinput == 'exit'
      end
    end

  end

  puts tictactoe.exit_messages

  displaying_board.clear_board
  tictactoe.winner = -1
  tictactoe.new_game

  puts 'Game is over'
  puts 'do you want to play again Y/N?'

  input = ''
  until %w[EXIT N Y YES NO].include? input
    input = gets.chomp.to_s.upcase # exit
    puts "#{input} not a valid option" unless %w[EXIT N Y YES NO].include? input
  end

end

p 'Thank you for playing'
p 'closing ....'
exit

# rubocop:enable Metrics/BlockNesting
