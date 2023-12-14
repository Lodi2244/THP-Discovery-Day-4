# Cell model used during maze creation to store available directions for each cell
class Cell
  attr_accessor :available_directions, :visited, :column, :row
  def initialize(column, row)
    # Cell position
    @column = column
    @row = row
    # Available movement directions N,S,E,W
    @available_directions = []
    # Keep track for maze creation
    @visited = false
  end
end
