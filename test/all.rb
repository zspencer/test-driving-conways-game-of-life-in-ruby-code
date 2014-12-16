require 'minitest/autorun'

class GameOfLife
  def initialize(world, iterator)
    @world = world
  end

  def run!()
  end

  def world()
    @world
  end
end

class TurnTaker
  def initialize(quantity)
  end
end

class TestGameOfLife < MiniTest::Test
  def test_an_empty_world_after_a_single_iteration
    game_of_life = GameOfLife.new([], TurnTaker.new(1))
    game_of_life.run!()
    assert_equal([], game_of_life.world())
  end

  def test_a_world_with_a_con_at_0_0_with_two_neighbors_keeps_the_con_with_the_neighbors_after_a_single_iteration
    starting_world = [{:x => 0, :y => 0}, {:x => 1, :y => 1}, {:x => 0, :y => 1}]
    game_of_life = GameOfLife.new(starting_world, TurnTaker.new(1))
    game_of_life.run!()

    assert(game_of_life.world.include?({:x => 0, :y => 0}), "The Con at 0,0 didn't survive!")
  end
end
