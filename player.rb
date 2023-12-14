class Player
  
  attr_accessor :column, :row
  
  def initialize
    @column = 0
    @row = 0
  end

  def move_up(maze)
    if maze.cells[column][row].available_directions.include?('Up')
      @row -= 1 unless @row == 0
    end
  end

  def move_down(maze)
    if maze.cells[column][row].available_directions.include?('Down')
      @row += 1 unless @row == maze.height - 1 
    end
  end

  def move_right(maze)
    if maze.cells[column][row].available_directions.include?('Right')
      @column += 1 unless @column == maze.width - 1 
    end
  end

  def move_left(maze)
    if maze.cells[column][row].available_directions.include?('Left')
      @column -= 1 unless @column == 0 
    end
  end

  def position 
    { column: @column, row: @row }
  end 
end
