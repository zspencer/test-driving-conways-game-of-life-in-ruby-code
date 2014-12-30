require 'minitest/autorun'

class GameOfLife

end

class TestGameOfLife < MiniTest::Test
  def test_a_con_at_5_5_with_no_neighbors_dies_after_one_day
    con = { :x => 5, :y => 5 }
    population = [con]
    game = GameOfLife.new(population)
    game.run(1)

    failure_message = "Con #{con} survived in #{game.population} but wasn't supposed to!"
    refute(game.population.include?(con), failure_message)
  end
end
