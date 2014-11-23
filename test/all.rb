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

  def assert_alive(con, population)
    assert population.include?(con), "Con #{target_con} was supposed to be alive and was not found in #{population}!"
  end

  def refute_alive(con, population)
    refute population.include?(con), "Con #{target_con} was supposed to be dead but was found in #{population}"
  end

  def test_dies_when_standing_alone
    cons = [ target_con ]
    refute_alive(target_con, next_day(cons))
  end

  def test_stays_alive_with_west_and_east_neighbors
    cons = [ target_con,
             { :x => 1,  :y => 0 },
             { :x => -1, :y => 0 } ]

    assert_alive(target_con, next_day(cons))
  end

  def test_dies_with_four_neighbors
    cons = [ target_con,
             { :x => 1,  :y => -1 },
             { :x => 1,  :y => 0  },
             { :x => -1, :y => 0  },
             { :x => -1, :y => -1 } ]

    refute_alive(target_con, next_day(cons))
  end

  def test_stays_alive_with_east_and_west_neighbors_despite_other_cons_in_population
    cons = [ target_con,
             { :x => 1,  :y => -1 },
             { :x => 1,  :y => 0  },
             { :x => -3, :y => 3  },
             { :x => -3, :y => -3 } ]

    assert_alive(target_con, next_day(cons))
  end

  def test_stays_alive_with_north_and_south_neighbors_despite_other_cons_in_population
    cons = [ target_con,
             { :x => 0,  :y => -1 },
             { :x => 0,  :y => 1  },
             { :x => -3, :y => 3  },
             { :x => -3, :y => -3 } ]

    assert_alive(target_con, next_day(cons))
  end

  def test_dies_with_no_neighors_even_if_non_neighbors_are_east
    cons = [ target_con,
             { :x => -5,  :y => -1 },
             { :x => -5,  :y => 0  },
             { :x => -5,  :y => 1  }]

    refute_alive(target_con, next_day(cons))
  end
end
