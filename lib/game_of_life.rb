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
end

class World
  def initialize(cons)
    @cons = cons
  end

  def next_generation
    next_cons = survivors + newborns
    World.new(next_cons.uniq)
  end

  def to_a
    @cons.map(&:to_h)
  end

  private
  def survivors
    @cons.select do |con|
      con.survives?(neighbors(con))
    end
  end

  def newborns
    empty_spaces.select do |space|
      space.born?(neighbors(space))
    end
  end

  def neighbors(current)
    @cons.select() do |con|
      current.neighbor?(con)
    end
  end

  def empty_spaces
    @cons.reduce([]) do |spaces, c|
      spaces + c.around
    end
  end
end

class Con
  MAX_NUMBER_OF_NEIGHBORS_TO_SURVIVE = 3
  MIN_NUMBER_OF_NEIGHBORS_TO_SURVIVE = 2
  NUMBER_OF_NEIGHBORS_TO_BE_BORN = 3
  attr_reader :location


  def initialize(location)
    @location = location
  end

  def survives?(neighbors)
    neighbors.length == MAX_NUMBER_OF_NEIGHBORS_TO_SURVIVE ||
      neighbors.length == MIN_NUMBER_OF_NEIGHBORS_TO_SURVIVE
  end

  def born?(neighbors)
    neighbors.length == NUMBER_OF_NEIGHBORS_TO_BE_BORN
  end

  def neighbor?(coord)
    !(self == coord) && (near?(:x, coord) && near?(:y, coord))
  end

  def around
    near(:x).reduce([]) do |nearby, x|
      near(:y).each do |y|
        nearby.push(Con.new({:x => x, :y => y}))
      end
      nearby
    end
  end

  def ==(other)
    location[:x] == other.location[:x] && location[:y] == other.location[:y]
  end

  alias_method :eql?, :==

  alias_method :to_h, :location

  def hash
    [location[:x],location[:y]].hash
  end

  private

  def near?(axis, coord)
    near(axis).include?(coord.location[axis])
  end

  def near(axis)
    (location[axis] -1 .. location[axis] +1)
  end
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
