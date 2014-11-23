require 'minitest/autorun'
path_to_lib = File.expand_path(File.join(File.dirname(__FILE__), "..", "lib"))
$LOAD_PATH.unshift(path_to_lib)

require 'game_of_life'

class TestTransitionAtEndOfDay < Minitest::Test
  def test_a_con_standing_alone_dies_at_end_of_day
    cons = [ { :x => 0, :y => 0 } ]

    next_days_cons = GameOfLife.transition_at_end_of_day(cons)

    assert_equal [], next_days_cons
  end

  def test_a_con_with_two_neighbors_stays_alive

    target_con = { :x => 0, :y => 0 }
    cons = [ target_con,
             { :x => 1, :y => 0 },
             { :x => -1, :y => 0 } ]

    next_days_cons = GameOfLife.transition_at_end_of_day(cons)

    assert next_days_cons.include?(target_con), "Con #{target_con} was not found!"
  end
end
