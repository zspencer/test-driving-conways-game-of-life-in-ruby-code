class TestAConAtZeroZeroAtEndOfDay < ConTest
  def target_con
    { :x => 0, :y => 0 }
  end

  def test_dies_when_standing_alone
    cons = [ target_con ]
    refute_alive(target_con, next_generation(cons))
  end

  def test_stays_alive_with_west_and_east_neighbors
    cons = [ target_con,
             { :x => 1,  :y => 0 },
             { :x => -1, :y => 0 } ]

    assert_alive(target_con, next_generation(cons))
  end

  def test_dies_with_four_neighbors
    cons = [ target_con,
             { :x => 1,  :y => -1 },
             { :x => 1,  :y => 0  },
             { :x => -1, :y => 0  },
             { :x => -1, :y => -1 } ]

    refute_alive(target_con, next_generation(cons))
  end

  def test_stays_alive_with_east_and_west_neighbors_despite_other_cons_in_population
    cons = [ target_con,
             { :x => 1,  :y => -1 },
             { :x => 1,  :y => 0  },
             { :x => -3, :y => 3  },
             { :x => -3, :y => -3 } ]

    assert_alive(target_con, next_generation(cons))
  end

  def test_stays_alive_with_north_and_south_neighbors_despite_other_cons_in_population
    cons = [ target_con,
             { :x => 0,  :y => -1 },
             { :x => 0,  :y => 1  },
             { :x => -3, :y => 3  },
             { :x => -3, :y => -3 } ]

    assert_alive(target_con, next_generation(cons))
  end

  def test_dies_with_no_neighors_even_if_non_neighbors_are_east
    cons = [ target_con,
             { :x => -5,  :y => -1 },
             { :x => -5,  :y => 0  },
             { :x => -5,  :y => 1  }]

    refute_alive(target_con, next_generation(cons))
  end

  def test_dies_even_if_there_are_three_of_the_same_cell
    cons = [ target_con,
             target_con,
             target_con ]

    refute_alive(target_con, next_generation(cons))
  end

  def test_is_born_if_there_are_three_neighbors
    cons = [ { :x => 1, :y => 0 },
             { :x => -1, :y => 0 },
             { :x => -1, :y => 1 } ]

    assert_alive(target_con, next_generation(cons))
  end
end
