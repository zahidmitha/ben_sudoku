module Sudoku
  def self.row_index(cell_index)
    cell_index / 9
  end

  def self.column_index(cell_index)
    cell_index % 9
  end

  def self.box_index(row, column)
    # the boxes are numbered from left to right, top to bottom
    # hence the box index is the (row - row % 3) + (column / 3) e.g.
    # row 5, column 7 is in box 5:  (5 - (5 % 2)) + (7 /3) = (5 - 2) + (2) = 5
    (row - row % 3) + column / 3
  end

  def self.box_cell_index(row, column)
    # box cell index is ((row % 3) * 3) + (column % 3)
    (row % 3) * 3 + column % 3
  end


  def self.solve(puzzle)
    # Make a private copy of the puzzle that we can modify.
    original = puzzle
    puzzle = original.dup
    # Use logic to fill in as much of the puzzle as we can.
    # This method mutates the puzzle we give it, but always leaves it valid.
    # It returns a row, a column, and set of possible values at that cell.
    # Note parallel assignment of these return values to three variables.
    possibilities = scan(puzzle)

    # If we solved it with logic, return the solved puzzle.
    return puzzle if possibilities.empty?
    # Otherwise, try each of the possible_values in each of the possibilities
    # Since we're picking from a set of possible values, the guess leaves
    # the puzzle in a valid state. The guess will either lead to a solution
    # or to an impossible puzzle. We'll know we have an impossible
    # puzzle if a recursive call to scan throws an exception. If this happens
    # we need to try another guess, or re-raise an exception if we've tried
    # all the options we've got.
    possibilities.each do |possibility|
      puzzle = original.dup
      possibility.possible_values.each do |guess| # For each value in the set of possible values
        puzzle.rows[possibility.row][possibility.column].guess guess # Guess the value
        begin
          # Now try (recursively) to solve the modified puzzle.
          # This recursive invocation will call scan() again to apply logic
          # to the modified board, and will then guess another cell if needed.
          # Remember that solve() will either return a valid solution or
          # raise an exception.
          return solve(puzzle) # If it returns, we just return the solution
        rescue
          # If it raises an exception, try the next guess
        end
      end
    end

    # If we get here, then none of our guesses worked out
    # so we must have guessed wrong sometime earlier.
    raise "This puzzle cannot be solved"
  end

  private

  # This method scans a Puzzle, looking for unknown cells that have only
  # a single possible value. If it finds any, it sets their value. Since
  # setting a cell alters the possible values for other cells, it
  # continues scanning until it has scanned the entire puzzle without
  # finding any cells whose value it can set.
  #
  # This method returns three values. If it solves the puzzle, all three
  # values are nil. Otherwise, the first two values returned are the row and
  # column of a cell whose value is still unknown. The third value is the
  # set of values possible at that row and column. This is a minimal set of
  # possible values: there is no unknown cell in the puzzle that has fewer
  # possible values. This complex return value enables a useful heuristic
  # in the solve() method: that method can guess at values for cells where
  # the guess is most likely to be correct.
  #
  # This method raises Impossible if it finds a cell for which there are
  # no possible values. This can happen if the puzzle is over-constrained,
  # or if the solve() method below has made an incorrect guess.
  #
  # This method mutates the specified Puzzle object in place.
  # If has_duplicates? is false on entry, then it will be false on exit.
  #
  def self.scan(puzzle)
    solve_initial puzzle
    find_possibilities puzzle
  end

  def self.find_possibilities(puzzle)
    possibilities = []

    puzzle.each_unknown do |row, column, box|
      values = puzzle.possible_values_for(row, column, box)
      possibilities << Possibility.new(row, column, values) if values.count > 1
    end
    possibilities.sort { |x, y| x.possible_values.count <=> y.possible_values.count }
  end

  def self.solve_initial(puzzle)
    unchanged = false
    until unchanged
      unchanged = true # Assume no cells will be changed this time

      # Loop through cells whose value is unknown.
      puzzle.each_unknown do |row, column, box|
        # Find the set of values that could go in this cell
        values = puzzle.possible_values_for(row, column, box)
        # Branch based on the size of the set possible_values
        case values.count
        when 0 # No possible values means the puzzle is over-constrained
          raise "This puzzle cannot be solved"

        when 1 # We've found a unique value, so set it in the grid
          puzzle.rows[row][column].value = values.first
          unchanged = false
        end
      end
    end
  end
end