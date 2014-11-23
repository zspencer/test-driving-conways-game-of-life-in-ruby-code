require 'minitest/autorun'

module GameOfLife
  def self.transition_at_end_of_day(cons)
    []
  end
end

class TestTransitionAtEndOfDay < Minitest::Test
  def test_a_con_standing_alone_dies_at_end_of_day
    cons = [ { :x => 0, :y => 0 } ]

    next_days_cons = GameOfLife.transition_at_end_of_day(cons)

    assert_equal [], next_days_cons
  end
end
