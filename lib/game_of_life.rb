module GameOfLife
  NEIGHBORS_NEEDED_TO_SURVIVE = (2..3)

  def self.next_day(cons)
    neighbors = cons.select { |c|
      c[:x] == 1  || c[:x] == -1
    }

    if NEIGHBORS_NEEDED_TO_SURVIVE.cover?(neighbors.length)
      cons
    else
      []
    end
  end
end

