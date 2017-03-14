require "minitest/autorun"
require_relative "../src/minesweeper.rb"

class TestMinesweeper < Minitest::Test
  def test_coords()
    assert(Coord.new(1, 1).adjacent_to(Coord.new(1, 0)))
    assert(Coord.new(1, 1).adjacent_to(Coord.new(0, 1)))
    assert(Coord.new(1, 1).adjacent_to(Coord.new(2, 2)))

    assert(!Coord.new(1, 1).adjacent_to(Coord.new(1, 1)))
    assert(!Coord.new(1, 1).adjacent_to(Coord.new(2, 3)))
  end

  def test_field()
    field = MineField.new(4, 4)
    field.drop_mine(Coord.new(2, 2))

    assert_equal(1, field.hint(Coord.new(1, 2)))
    assert_equal(1, field.hint(Coord.new(3, 3)))
    assert_equal(0, field.hint(Coord.new(0, 2)))
  end
end
