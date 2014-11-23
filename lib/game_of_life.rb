module GameOfLife
  class UI
    def initialize(width, height)
      @width = width
      @height = height
    end

    def draw(population)
      (0...@height).map do |y|
        (0...@width).map do |x|
          possible_con = { :x => x - (@width / 2), :y => y - (@height / 2)}
          if population.include?(possible_con)
            "0"
          else
            " "
          end
        end.join("")
      end.map do |row|
         "X#{row}X"
       end.join("\n")
    end
  end

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
      births + births_near(con, population, births)
    end
  end

  def self.born?(con, population, births)
    count_neighbors(con, population) == NEIGHBORS_NEEDED_TO_BE_BORN &&
      !births.include?(con) &&
      !population.include?(con)
  end

  def self.count_neighbors(con, population)
    population.select { |con_b|
      neighbors?(con, con_b)
    }.length
  end

  def self.neighbors?(con_a, con_b)
    neighbors_of(con_a).include?(con_b)
  end

  def self.births_near(con, population, births)
    neighbors_of(con).select do |neighbor|
      born?(neighbor, population, births)
    end
  end

  def self.neighbors_of(con)
    neighbors = []
    (-1..1).each do |x|
      (-1..1).each do |y|
        neighbor = { :x => con[:x] + x, :y => con[:y] + y }
        neighbors.push(neighbor) if neighbor != con
      end
    end
    neighbors
  end
end
