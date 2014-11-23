module GameOfLife
  NEIGHBORS_NEEDED_TO_SURVIVE = (2..3)

  def self.next_generation(cons)
    cons.select do |con|
      neighbors = count_neighbors(con, cons)
      NEIGHBORS_NEEDED_TO_SURVIVE.cover?(neighbors)
    end
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

