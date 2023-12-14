require_relative 'player'
require_relative 'maze'
require 'io/console'

class Game 
  def initialize
    @maze = Maze.new(width: 10, height: 10)
    @player = Player.new
    @exit_position = { column: @maze.width - 1, row: @maze.height - 1 }
  end

  def play
    
    ## Loop method to display the maze and ask the user to choose a direction
    
    puts "\n 🎉 YOU WIN !! 🎉 \n" 
  end

  def display_maze 
    puts @maze.display(@player)
  end 

  def choose_direction
    puts "\n Use arrow keys to move  \n"
    # Get single character (without showing on screen)
    key_pressed = STDIN.noecho(&:getch)
    # Check if special character entered is an arrow key
    if key_pressed == "\e"
      # Retrieve rest of special character
      2.times do
        key_pressed += STDIN.getch
      end
    end
    
    ## Method to move the player in the right direction depending on the key pressed
    
  end 

  def in_the_maze?(player)
    return true unless player.position.eql?(@exit_position) 
  end 

end 

Game.new.play
