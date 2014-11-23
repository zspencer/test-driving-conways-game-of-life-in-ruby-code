module GameOfLife
  NEIGHBORS_NEEDED_TO_SURVIVE = (2..3)
  NEIGHBORS_NEEDED_TO_BE_BORN = 3

  def self.next_generation(population)
    survivors(population) + births(population)
  end

  def self.survivors(population)
    population.select do |con|
      survives?(con, population)
    end
  end

  def self.survives?(con, population)
    neighbors = count_neighbors(con, population)
    NEIGHBORS_NEEDED_TO_SURVIVE.cover?(neighbors)
  end

  def self.births(population)
    [{ :x => 0, :y => 0}].select do |con|
      born?(con, population)
    end
  end

  def self.born?(con, population)
    count_neighbors(con, population) == NEIGHBORS_NEEDED_TO_BE_BORN
  end

  def self.count_neighbors(con, population)
    population.select { |con_b|
      neighbors?(con, con_b)
    }.length
  end

  def self.neighbors?(con_a, con_b)
    con_a != con_b &&
    con_a[:x] <= con_b[:x] + 1 &&
    con_a[:x] >= con_b[:x] -1 &&
    con_a[:y] <= con_b[:x] + 1 &&
    con_a[:y] >= con_b[:x] -1
  end
end
