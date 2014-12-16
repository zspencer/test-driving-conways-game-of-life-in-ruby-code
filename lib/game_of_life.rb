src_dir = File.expand_path(File.join(__FILE__, ".."))
Dir.glob("#{src_dir}/game_of_life/**/*.rb").each do |f|
  require File.expand_path(f)
end

class GameOfLife
  def initialize(world, iterator)
    cons = world.map do |con|
      Con.new(con)
    end
    @iterator = iterator
    @world = World.new(cons)
  end

  def run!(&callback)
    @iterator.run do
      yield(@world.to_a) if block_given?
      @world = @world.next_generation
    end
  end

  def world()
    @world.to_a
  end

  class TurnTaker
    def initialize(quantity = false)
      @quantity = quantity
    end

    def run
      if @quantity
        @quantity.times do
          yield
        end
      else
        while true
          yield
        end
      end
    end
  end
end

if __FILE__ == $0
  starting_cons = []
  (0..40).each do |x|
    (0..20).each do |y|
      starting_cons.push({:x => x, :y => y}) if rand(4) == 1
    end
  end
  require 'terminfo'
  lines, cols = TermInfo.screen_size()
  ui = GameOfLife::UI.new(cols, lines)
  game_of_life = GameOfLife.new(starting_cons, GameOfLife::TurnTaker.new())
  game_of_life.run! do |world|
    puts ui.draw(world)
  end
end
