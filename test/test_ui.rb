require 'minitest/autorun'
$LOAD_PATH.unshift(File.expand_path(File.join(__FILE__, "..", "..", "lib")))
require 'game_of_life/ui'

class TestGameOfLifeUI < MiniTest::Test
  def test_drawing_a_1_by_1_world_with_a_con_at_0_0
    ui = GameOfLife::UI.new(1,1)

    output = ui.draw([{:x => 0, :y => 0}])
    assert_equal(["X"].join("\n"), output)
  end

  def test_drawing_an_empty_1_by_1_world
    ui = GameOfLife::UI.new(1,1)

    output = ui.draw([])
    assert_equal([" "].join("\n"), output)
  end
end
