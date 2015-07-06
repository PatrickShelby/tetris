#compute position
#compute rotation

require "timeout"

class Piece
  attr_accessor :shape

  def initialize
    @shape = type_of_piece
  end

  def type_of_piece
    @s = [[1,4],[1,5],[0,5],[0,6]]
    @z = [[0,4],[0,5],[1,5],[1,6]]
    @stick = [[0,4],[0,5],[0,6],[0,7]]
    @block = [[0,4],[0,5],[1,5],[1,4]]
    @tee = [[1,4],[1,5],[1,6],[0,5]]
    @ell = [[0,4],[1,4],[1,5],[1,6]]
    @rell = [[1,4],[1,5],[1,6],[0,6]]
    [@s,@z,@stick,@block,@tee,@ell,@rell].sample
  end

  def drop
    @shape.each do |posit|
      posit[0] += 1
    end
  end

  def rotate
  end

  def move(direction)
    if direction == "n"
      @shape.each do |posit|
        posit[1] += 1
      end
    elsif direction == "b"
      @shape.each do |posit|
        posit[1] -= 1
      end
    else
      time = Time.now

    end
  end
end

#Start new piece at y of 20, x of 5
class Board
  attr_accessor :grid
  def initialize
    @height = 20
    @width = 10
    @grid = []
  end

  def draw_board
    @grid = []
    @height.times do
      @grid << []
    end
    @grid.each do |row|
      @width.times do
        row << "_"
      end
    end
  end

  def display_board
    sleep(0.25)
    puts "\e[H\e[2J"
    @grid.each do |row|
     row.each do |char|
      print "#{char}"
    end
    puts "\n"
  end
end
end


class Game
  def new_game
    @board = Board.new
    @board.draw_board
    @current_piece = Piece.new
    draw_piece
    @board.display_board
  end

  def draw_piece
    @current_piece.shape.each do |coord|
      @board.grid[coord[0]][coord[1]] = "X"
    end
  end

  def gravity
   @current_piece.drop
 end

 def run
   new_game
   17.times do
      @current_piece.move(gets.chomp)
      @board.draw_board
      draw_piece
      @board.display_board
  end
    # unless game_over?
    #   # call a new piece
    #   # loop
    #     # drop piece using gravity
    #     gravity
    #     # if piece hits the bottom or another piece
    #       # check if their is a full line
    #       # call a new piece
    #   # end loop
    # end
  end
end


new_game = Game.new
new_game.run


