module GameOfLife
  NEIGHBORS_NEEDED_TO_SURVIVE = (2..3)

  def self.next_day(cons)
    if NEIGHBORS_NEEDED_TO_SURVIVE.cover?(count_neighbors(cons))
      cons
    else
      []
    end
  end

  def self.count_neighbors(population)
    population.select { |c|
      c[:x] == 1  ||
      c[:x] == -1 ||
      c[:y] == -1
    }.length
  end
end

