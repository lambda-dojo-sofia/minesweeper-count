require "minitest/autorun"
require_relative "../src/minesweeper.rb"
require_relative "../src/minesweeper_helpers.rb"

class TestMinesweeperHelpers < Minitest::Test
  def test_lines_to_fields
    fields = lines_to_fields([
      '4 4',
      '*...',
      '....',
      '.*..',
      '....',
      '3 5',
      '**...',
      '.....',
      '.*...',
      '0 0'
    ])

    assert_equal(2, fields.length)

    assert(fields[0].boom(Coord.new(0, 0)))
    assert(fields[0].boom(Coord.new(2, 1)))
    assert(!fields[0].boom(Coord.new(2, 2)))

    assert(fields[1].boom(Coord.new(0, 0)))
    assert(fields[1].boom(Coord.new(0, 1)))
    assert(fields[1].boom(Coord.new(2, 1)))
    assert(!fields[1].boom(Coord.new(2, 2)))
  end
end
