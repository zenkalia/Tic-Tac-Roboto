COMPUTER = 'O'

def board_to_s(board, index)
  board[index] == ' ' ? index + 1 : board[index]
end

def draw_board(board)
  puts "#{board_to_s(board, 0)}|#{board_to_s(board, 1)}|#{board_to_s(board, 2)}"
  puts '-+-+-'
  puts "#{board_to_s(board, 3)}|#{board_to_s(board, 4)}|#{board_to_s(board, 5)}"
  puts '-+-+-'
  puts "#{board_to_s(board, 6)}|#{board_to_s(board, 7)}|#{board_to_s(board, 8)}"
end

def take_turn(board, turn)
  puts "It is #{turn}'s turn:"
  if turn == COMPUTER
    turn = next_turn(turn) if place_letter(board, turn, ai_turn(board))
  else
    response = gets
    index = response.strip.to_i
    valid_move = index && index >= 1 && index <= 9
    if valid_move
      turn = next_turn(turn) if place_letter board, turn, index - 1
    else
      puts 'Not a number'
    end
  end
  draw_board board
  check_end board
  take_turn board, turn
end

def place_letter(board, turn, index)
  if board[index] == ' '
    board[index] = turn
    return true
  end
  puts 'That spot is already taken'
  return false
end

def next_turn(turn)
  case turn
  when 'X'
    'O'
  when 'O'
    'X'
  end
end

def check_end(board)
  wins = [[0, 1, 2],
          [3, 4, 5],
          [6, 7, 8],
          [0, 3, 6],
          [1, 4, 7],
          [2, 5, 8],
          [0, 4, 8],
          [2, 4, 6]]
  wins.each do |win|
    winner = board[win[0]]
    next if winner == ' '
    if board[win[0]] == board[win[1]] && board[win[1]] == board[win[2]]
      puts "#{winner} wins!"
      exit
    end
  end
  unless board.index(' ')
    puts 'Stalemate, the board is full'
    exit
  end
end

def ai_turn(board)
  (1..9).to_a.sample
end

puts 'Welcome to Tic Tac Toe'
puts '(quit with ctrl+d)'
puts 'Get ready. Press enter.'
gets
puts 'Starting game against computer'
board = Array.new(9, ' ')
turn = 'X'
draw_board board
take_turn board, turn
