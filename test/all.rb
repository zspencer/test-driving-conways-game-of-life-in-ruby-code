require 'minitest/autorun'

class GameOfLife
  def initialize(world, iterator)
  end

  def run!()
  end

  def world()
    []
  end
end

class Iterator
  def initialize(quantity)
  end
end

class TestGameOfLife < MiniTest::Test
  def test_an_empty_world_after_a_single_iteration
    game_of_life = GameOfLife.new([], Iterator.new(1))
    game_of_life.run!()
    assert_equal(game_of_life.world, [])
  end
end
