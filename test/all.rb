require 'minitest/autorun'

path_to_lib = File.expand_path(File.join(File.dirname(__FILE__), "..", "lib"))
$LOAD_PATH.unshift(path_to_lib)
require 'game_of_life'

class ConTest < Minitest::Test
  def next_generation(cons)
    GameOfLife.next_generation(cons)
  end

  def assert_alive(con, population)
    assert population.include?(con), "Con #{target_con} was supposed to be alive and was not found in #{population}!"
  end

  def refute_alive(con, population)
    refute population.include?(con), "Con #{target_con} was supposed to be dead but was found in #{population}"
  end
end


path_to_test = File.expand_path(File.join(File.dirname(__FILE__)))
$LOAD_PATH.unshift(path_to_test)

require 'test_a_con_at_0_0_at_end_of_day'
require 'test_a_con_at_10_10_at_end_of_day'
require 'test_ui'
