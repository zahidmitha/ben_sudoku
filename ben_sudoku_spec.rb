require './lib/sudoku'

# 003 020 600
# 900 305 001
# 001 806 400
#
# 008 102 900
# 700 000 008
# 006 708 200
#
# 002 609 500
# 800 203 009
# 005 010 300

describe Sudoku do


  context '.row_index' do
    it 'returns the correct row for a given cell number' do
      Sudoku.row_index(0).should eq 0
      Sudoku.row_index(10).should eq 1
      Sudoku.row_index(21).should eq 2
      Sudoku.row_index(29).should eq 3
      Sudoku.row_index(37).should eq 4
      Sudoku.row_index(48).should eq 5
      Sudoku.row_index(57).should eq 6
      Sudoku.row_index(63).should eq 7
      Sudoku.row_index(80).should eq 8
    end
  end

  context '.column_index' do
    it 'returns the correct column for a given cell number' do
      Sudoku.column_index(0).should eq 0
      Sudoku.column_index(10).should eq 1
      Sudoku.column_index(20).should eq 2
      Sudoku.column_index(30).should eq 3
      Sudoku.column_index(40).should eq 4
      Sudoku.column_index(50).should eq 5
      Sudoku.column_index(60).should eq 6
      Sudoku.column_index(70).should eq 7
      Sudoku.column_index(80).should eq 8
    end
  end

  context '.box_index' do
    it 'returns the box column for a given cell number' do
      Sudoku.box_index(0, 0).should eq 0
      Sudoku.box_index(0, 5).should eq 1
      Sudoku.box_index(0, 8).should eq 2
      Sudoku.box_index(5, 2).should eq 3
      Sudoku.box_index(5, 4).should eq 4
      Sudoku.box_index(5, 6).should eq 5
      Sudoku.box_index(8, 1).should eq 6
      Sudoku.box_index(8, 3).should eq 7
      Sudoku.box_index(8, 8).should eq 8
    end
  end

  context 'given a puzzle' do
    it 'should solve the puzzle' do
      puzzle = Sudoku::Puzzle.new '003020600900305001001806400008102900700000008006708200002609500800203009005010300'

      puts "\n#{puzzle}"

      expect { puzzle = Sudoku.solve(puzzle) }.to_not raise_error

      puts "\n#{puzzle}"
    end
  end

  context 'given a very difficult puzzle' do
    it 'should solve the puzzle' do
      puzzle = Sudoku::Puzzle.new '800000000003600000070090200050007000000045700000100030001000068008500010090000400'

      puts "\n#{puzzle}"

      expect { puzzle = Sudoku.solve(puzzle) }.to_not raise_error

      puts "\n#{puzzle}"
    end
  end
end