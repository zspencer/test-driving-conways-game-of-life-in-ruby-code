class GameOfLife
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
end
