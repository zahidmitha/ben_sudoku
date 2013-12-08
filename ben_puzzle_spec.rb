require './lib/puzzle'

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

describe Sudoku::Puzzle do

  let(:puzzle) { Sudoku::Puzzle.new '003020600900305001001806400008102900700000008006708200002609500800203009005010300' }

  context '.new' do
    it 'accepts a new grid as a single string of numbers' do
      puzzle
    end

    it 'has 9 rows' do
      puzzle.rows.count.should eq 9
    end

    it 'has 9 columns' do
      puzzle.columns.count.should eq 9
    end

    it 'has 9 boxes' do
      puzzle.boxes.count.should eq 9
    end

    it 'has correct values in columns' do
      puzzle.columns[2][0].value.should eq '3'
      puzzle.columns[4][0].value.should eq '2'
      puzzle.columns[6][0].value.should eq '6'

      puzzle.columns[0][1].value.should eq '9'
      puzzle.columns[3][1].value.should eq '3'
      puzzle.columns[5][1].value.should eq '5'
      puzzle.columns[8][1].value.should eq '1'

      puzzle.columns[2][2].value.should eq '1'
      puzzle.columns[3][2].value.should eq '8'
      puzzle.columns[5][2].value.should eq '6'
      puzzle.columns[6][2].value.should eq '4'
    end

    it 'has correct values in rows' do
      puzzle.rows[3][2].value.should eq '8'
      puzzle.rows[3][3].value.should eq '1'
      puzzle.rows[3][5].value.should eq '2'
      puzzle.rows[3][6].value.should eq '9'

      puzzle.rows[4][0].value.should eq '7'
      puzzle.rows[4][8].value.should eq '8'

      puzzle.rows[5][2].value.should eq '6'
      puzzle.rows[5][3].value.should eq '7'
      puzzle.rows[5][5].value.should eq '8'
      puzzle.rows[5][6].value.should eq '2'
    end

    it 'has correct values in boxes' do
      puzzle.boxes[6][2].value.should eq '2'
      puzzle.boxes[6][3].value.should eq '8'
      puzzle.boxes[6][8].value.should eq '5'

      puzzle.boxes[7][0].value.should eq '6'
      puzzle.boxes[7][2].value.should eq '9'
      puzzle.boxes[7][3].value.should eq '2'
      puzzle.boxes[7][5].value.should eq '3'
      puzzle.boxes[7][7].value.should eq '1'

      puzzle.boxes[8][0].value.should eq '5'
      puzzle.boxes[8][5].value.should eq '9'
      puzzle.boxes[8][6].value.should eq '3'
    end

    it 'is valid' do
      puzzle.valid?.should be_true
    end

    it 'can iterate unknown values' do
      puzzle = Sudoku::Puzzle.new '909929699990395991901896499998192999799990098996798299992699599890093999995919399'

      unknowns = []
      puzzle.each_unknown do |row, column, box|
        unknowns << [row, column, box]
      end
      unknowns.should eq [[0, 1, 0], [1, 2, 0], [2, 1, 0], [4, 5, 4], [4, 6, 5], [7, 2, 6], [7, 3, 7]]
    end

    it 'returns possible values for a specific row, column and box' do
      puzzle.possible_values_for(0,0,0).should eq ['4', '5']
      puzzle.possible_values_for(4,4,4).should eq ['3', '4', '5', '6', '9']
    end
  end
end