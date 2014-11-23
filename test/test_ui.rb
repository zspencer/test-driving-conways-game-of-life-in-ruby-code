class TestUI < Minitest::Test

  def test_drawing_a_cell_at_0_0
    ui = GameOfLife::UI.new(11, 3)
    output = ui.draw([{:x => 0, :y => 0 }])


    assert_equal(["X           X",
                  "X     0     X",
                  "X           X"].join("\n"), output)

  end
end
