require 'minitest/autorun'

class GameOfLife
  def initialize(world, iterator)
    cons = world.map do |con|
      Con.new(con)
    end
    @iterator = iterator
    @world = World.new(cons)
  end

  def run!()
    @iterator.run do
      @world = @world.next_generation
    end
  end

  def world()
    @world.to_a
  end
end

class World
  def initialize(cons)
    @cons = cons
  end

  def next_generation
    next_cons = @cons.select do |con|
      con.survives?(self)
    end

    World.new(next_cons)
  end

  def neighbors(current)
    @cons.select() do |con|
      current.neighbor?(con)
    end
  end

  def to_a
    @cons.map(&:to_h)
  end
end

class Con
  MAX_NUMBER_OF_NEIGHBORS_TO_SURVIVE = 3
  MIN_NUMBER_OF_NEIGHBORS_TO_SURVIVE = 2

  attr_reader :location
  def initialize(location)
    @location = location
  end

  def neighbor?(con)
    ((location[:x] - 1.. location[:x] + 1).include?(con.location[:x]) || (location[:y] - 1.. location[:y] + 1).include?(con.location[:y])) &&
      !(self == con)
  end

  def survives?(world)
    world.neighbors(self).length == MAX_NUMBER_OF_NEIGHBORS_TO_SURVIVE ||
      world.neighbors(self).length == MIN_NUMBER_OF_NEIGHBORS_TO_SURVIVE
  end

  def ==(other)
    location[:x] == other.location[:x] && location[:y] == other.location[:y]
  end

  alias_method :to_h, :location
end

class TurnTaker
  def initialize(quantity)
    @quantity = quantity
  end

  def run
    @quantity.times do
      yield
    end
  end
end

class TestGameOfLife < MiniTest::Test
  def setup_and_run_game_of_life(world, turns=1)
    game_of_life = GameOfLife.new(world, TurnTaker.new(turns))
    game_of_life.run!()
    game_of_life
  end

  def test_an_empty_world_after_a_single_iteration
    game_of_life = setup_and_run_game_of_life([])
    assert_equal([], game_of_life.world())
  end

  def test_a_world_with_a_con_at_0_0_with_two_neighbors_keeps_the_con_with_the_neighbors_after_a_single_iteration
    starting_world = [{:x => 0, :y => 0}, {:x => 1, :y => 1}, {:x => 0, :y => 1}]

    game_of_life = setup_and_run_game_of_life(starting_world)

    assert(game_of_life.world.include?({:x => 0, :y => 0}), "The Con at 0,0 didn't survive!")
  end

  def test_a_con_at_0_0_with_no_neighbors_dies_after_a_single_iteration
    starting_world = [{:x => 0, :y => 0}]

    game_of_life = setup_and_run_game_of_life(starting_world)

    refute(game_of_life.world.include?({:x => 0, :y => 0}), "The Con at 0,0 survived!")
  end

  def test_a_con_at_0_0_with_three_neighbors_survives_a_single_iteration
    starting_world = [{:x => 0, :y => 0}, { :x => 1, :y => 1 }, { :x => 0, :y => 1 }, { :x => 1, :y => 0 }]

    game_of_life = setup_and_run_game_of_life(starting_world)

    assert(game_of_life.world.include?({:x => 0, :y => 0}), "The Con at 0,0 didn't survive!")
  end

  def test_a_con_at_0_0_with_no_neighbors_but_two_non_neighbors_dies_after_a_single_iteration
    starting_world = [{:x => 0, :y => 0}, { :x => 3, :y => 3 }, { :x => 4, :y => 4 }]

    game_of_life = setup_and_run_game_of_life(starting_world)

    refute(game_of_life.world.include?({:x => 0, :y => 0}), "The Con at 0,0 did survive!")
  end

  def test_a_con_at_3_4_with_two_neighbors_survives_a_single_iteration
    starting_world = [{:x => 3, :y => 4}, { :x => 3, :y => 3 }, { :x => 4, :y => 4 }]

    game_of_life = setup_and_run_game_of_life(starting_world)

    assert(game_of_life.world.include?({:x => 3, :y => 4}), "The Con at 3,4 didn't survive!")
  end

  def test_a_con_with_two_neighbors_dies_after_two_iterations
    starting_world = [{:x => 2, :y => 2}, { :x => 3, :y => 3 }, { :x => 4, :y => 4 }]

    game_of_life = setup_and_run_game_of_life(starting_world, 2)

    refute(game_of_life.world.include?({:x => 3, :y => 3}), "The Con at 3,3 did survive!")
  end
end
