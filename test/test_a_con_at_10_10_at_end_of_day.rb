class TestAConAtTenTenAtEndOfDay < ConTest
  def target_con
    { :x => 10, :y => 10 }
  end

  def test_stays_alive_with_two_neighbors
    cons = [ target_con,
             { :x => 11,  :y => 11 },
             { :x => 11, :y => 10 } ]

    assert_alive(target_con, next_generation(cons))
  end
end
