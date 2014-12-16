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
    def initialize(quantity)
      @quantity = quantity
    end

    def run
      @quantity.times do
        yield
      end
    end
  end
end
