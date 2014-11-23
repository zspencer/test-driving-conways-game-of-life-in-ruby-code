module GameOfLife
  NEIGHBORS_NEEDED_TO_SURVIVE = (2..3)

  def self.next_generation(cons)
    if NEIGHBORS_NEEDED_TO_SURVIVE.cover?(count_neighbors(cons))
      cons
    else
      []
    end
  end

  def self.count_neighbors(population)
    population.select { |con|
      neighbors?(con)
    }.length
  end

  def self.neighbors?(con)
    con != { :x => 0, :y => 0 } &&
    con[:x] <= 1 && con[:x] >= -1 &&
    con[:y] <= 1 && con[:y] >= -1
  end
end

