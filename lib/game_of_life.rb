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
    population.reduce([]) do |births, con|
      births + births_near(con, population)
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

  def self.births_near(con, population)
    unborn_neighbors_of(con, population).select do |neighbor|
      born?(neighbor, population)
    end
  end

  def self.unborn_neighbors_of(con, population)
    neighbors = []
    (-1..1).each do |x|
      (-1..1).each do |y|
        dead_neighbor = { :x => con[:x] + x, :y => con[:y] + y }
        neighbors.push(dead_neighbor) unless population.include?(dead_neighbor)
      end
    end
    neighbors
  end
end
