require_relative 'cell'
require_relative 'player'
# Class used to create new maze
class Maze
  
  attr_accessor :width, :height, :cells
  
  PLAYER_ICON = "🤔"

  def initialize(width: , height:)
    # Set width and height 
    @width = width
    @height = height
    # empty stack used for maze creation
    @stack = []
    create_walls
    create_cells
    generate_maze
  end

  # Makes the maze into a string so that it can be printed out
  def display(player)
    # Add top Border
    output = '+   +' + '---+' * (@width - 1) + "\n"
    for row in 0...@height
      # Add vertical walls
      output += '|' # Leftside border
      for column in 0...@width
        # Add player symbol
        if column.eql?(player.position[:column]) and row.eql?(player.position[:row])
          output += @vertical_walls[column][row] ? "#{PLAYER_ICON} |" : " #{PLAYER_ICON} "
        else
          output += @vertical_walls[column][row] ? '   |' : '    '
        end
      end
      output += "\n+" # Rightside border
      # Add horizontal walls
      for column in 0...@width
        output += @horizontal_walls[column][row] ? '---+' : '   +'
      end
      output += "\n" # End of row
    end
    output
  end

  # Generates a new maze starting from random location
  def generate_maze
    # Randomises generator start location
    column = rand(@width)
    row = rand(@height)
    # Put starting cell onto stack
    @stack << @cells[column][row]
    create_path_from(column, row)
  end

  private

  # Recursive backtracker algorithm to create maze
  def create_path_from(column, row)
    # Maze done when stack is empty
    return if @stack.empty?
    # Mark current cell as visited
    @cells[column][row].visited = true
    options = get_options(column, row)
    # Return to previous cell if all surrounding cells have been visited
    if options.length == 0
      previous_cell = @stack.pop
      create_path_from(previous_cell.column, previous_cell.row)
    else
      # Randomlrow choose direction
      option = options[rand(options.length)]
      new_column, new_row = get_next_cell_position(option, column, row)
      # Tell current cell and new cell they can now move in chosen direction
      @cells[column][row].available_directions << option
      @cells[new_column][new_row].available_directions << opposite(option)
      # Push current cell onto stack
      @stack << @cells[column][row]
      # Remove wall between current cell and chosen cell
      remove_wall(column, row, option)
      # Restart method with new position
      create_path_from(new_column, new_row)
    end
  end

  # Remove wall between current cell and chosen direction
  def remove_wall(column, row, option)
    case option
    when "Up"
      @horizontal_walls[column][row-1] = false
    when "Down"
      @horizontal_walls[column][row] = false
    when "Right"
      @vertical_walls[column][row] = false
    when "Left"
      @vertical_walls[column-1][row] = false
    end
  end

  # Calculates new column, row coordinates for chosen direction
  def get_next_cell_position(option, column, row)
    case option
    when "Up"
      row -= 1
    when "Down"
      row += 1
    when "Right"
      column += 1
    when "Left"
      column -= 1
    end
    [column, row]
  end

  # Returns opposite direction
  def opposite(option)
    case option
    when "Up"
      "Down"
    when "Down"
      "Up"
    when "Right"
      "Left"
    when "Left"
      "Right"
    end
  end

  # Returns available options based on if they have been visited rowet
  def get_options(column, row)
    options = []
    # Check north cell
    if row > 0
      if @cells[column][row-1].visited == false
        options << 'Up'
      end
    end
    # Check south cell
    if row < @height - 1
      if @cells[column][row+1].visited == false
        options << 'Down'
      end
    end
    # Check east cell
    if column < @width - 1
      if @cells[column+1][row].visited == false
        options << 'Right'
      end
    end
    # Check west cell
    if column > 0
      if @cells[column-1][row].visited == false
        options << 'Left'
      end
    end
    options
  end

  # Creates 2d array for each cell width * height (column, row)
  def create_cells
    # Make empty array
    @cells = Array.new(@width) { Array.new(@height) }
    for column in 0...@width
      for row in 0...@height
        # Put new cell in each element of array
        @cells[column][row] = Cell.new(column, row)
      end
    end
  end

  # Creates array to store all walls and sets to true
  def create_walls
    # Create 2d array of all horizontal walls and set all to true
    @horizontal_walls = Array.new(@width) { Array.new(@height) { true } }
    # Same for vertical walls...
    @vertical_walls = Array.new(@width) { Array.new(@height) { true } }
    # Remove finish wall
    @horizontal_walls[-1][-1] = false
  end
end
