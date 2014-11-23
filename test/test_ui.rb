class TestUI < Minitest::Test

  def test_drawing_a_cell_at_0_0_on_11x3_grid
    output = GameOfLife::UI.draw([{:x => 0, :y => 0 }], 11, 3)


    assert_equal(["X           X",
                  "X     0     X",
                  "X           X"].join("\n"), output)
  end

  def test_drawing_a_cell_at_1_0_on_11x3_grid

    output =  GameOfLife::UI.draw([{:x => 1, :y => 0 }], 11, 3)
    assert_equal(["X           X",
                  "X      0    X",
                  "X           X"].join("\n"), output)
  end
end
