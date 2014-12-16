class GameOfLife
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
end
