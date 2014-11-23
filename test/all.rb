require 'minitest/autorun'
path_to_lib = File.expand_path(File.join(File.dirname(__FILE__), "..", "lib"))
$LOAD_PATH.unshift(path_to_lib)

require 'game_of_life'

class TestAConAtZeroZeroAtEndOfDay < Minitest::Test
  def target_con
    { :x => 0, :y => 0 }
  end

  def next_day(cons)
    GameOfLife.next_day(cons)
  end

  def test_dies_when_standing_alone
    cons = [ target_con ]
    refute next_day(cons).include?(target_con), "Con #{target_con} was found!"
  end

  def test_stays_alive_with_two_neighbors
    cons = [ target_con,
             { :x => 1,  :y => 0 },
             { :x => -1, :y => 0 } ]

    assert next_day(cons).include?(target_con), "Con #{target_con} was not found!"
  end
end
