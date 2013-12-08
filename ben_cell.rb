module Sudoku
  class Cell

    def initialize(value)
      @value = value
      @guess = false
    end

    def guess?
      @guess
    end

    def guess(value)
      @value = value
      @guess = true
    end

    def value
      @value
    end

    def value=(value)
      @value = value
      @guess = false
    end

    def unknown?
      return value == '0'
    end

    def to_s
      value
    end
  end
end