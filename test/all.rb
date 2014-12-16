require 'minitest/autorun'
$LOAD_PATH.unshift(File.expand_path(File.join(__FILE__, "..", "..", "lib")))
require 'game_of_life'

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

  def test_an_emtpy_space_at_3_4_with_three_neighbors_brings_a_con_to_life
    starting_world = [{:x => 3, :y => 5}, { :x => 3, :y => 3 }, { :x => 4, :y => 4 }]

    game_of_life = setup_and_run_game_of_life(starting_world)

    assert(game_of_life.world.include?({:x => 3, :y => 4}), "The Con at 3,4 didn't survive!")
  end

  def test_a_con_with_two_neighbors_dies_after_two_iterations
    starting_world = [{:x => 2, :y => 2}, { :x => 3, :y => 3 }, { :x => 4, :y => 4 }]

    game_of_life = setup_and_run_game_of_life(starting_world, 2)

    refute(game_of_life.world.include?({:x => 3, :y => 3}), "The Con at 3,3 did survive!")
  end

  def test_a_con_must_be_near_on_both_x_and_y_axis
    starting_world = [{:x => 3, :y => 8}, { :x => 3, :y => 3 }, { :x => 4, :y => 4 }]

    game_of_life = setup_and_run_game_of_life(starting_world)

    refute(game_of_life.world.include?({:x => 3, :y => 3}), "The Con at 3,3 did survive!")
  end
end
