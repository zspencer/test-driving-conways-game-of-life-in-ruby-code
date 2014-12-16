require 'minitest/autorun'

class GameOfLife
  MAX_NUMBER_OF_NEIGHBORS_TO_SURVIVE = 3
  MIN_NUMBER_OF_NEIGHBORS_TO_SURVIVE = 2

  def initialize(world, iterator)
    @world = world.map do |con|
      Con.new(con)
    end
  end

  def run!()
    @world = (survives?() ? @world : [])
  end

  def world()
    @world.map(&:location)
  end

  private

  def survives?
    neighbors().length == MAX_NUMBER_OF_NEIGHBORS_TO_SURVIVE ||
      neighbors().length == MIN_NUMBER_OF_NEIGHBORS_TO_SURVIVE
  end

  def neighbors
    current = Con.new({ :x => 0, :y => 0 })
    @world.select() do |con|
      current.neighbor?(con)
    end
  end
end

class Con
  attr_reader :location
  def initialize(coordinates)
    @location = coordinates
  end

  def neighbor?(con)
    ((-1..1).include?(con.location[:x]) || (-1..1).include?(con.location[:y])) &&
      !(self == con)
  end

  def ==(other)
    location[:x] == other.location[:x] && location[:y] == other.location[:y]
  end
end

class TurnTaker
  def initialize(quantity)
  end
end

class TestGameOfLife < MiniTest::Test
  def setup_and_run_game_of_life(world)
    game_of_life = GameOfLife.new(world, TurnTaker.new(1))
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
end
