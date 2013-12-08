class Possibility
  attr_accessor :row, :column, :possible_values

  def initialize(row, column, possible_values)
    @row, @column, @possible_values = row, column, possible_values
  end
end