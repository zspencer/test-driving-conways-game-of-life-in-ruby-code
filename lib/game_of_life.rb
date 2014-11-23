module GameOfLife
  NEIGHBORS_NEEDED_TO_SURVIVE = (2..3)

  def self.next_day(cons)
    if NEIGHBORS_NEEDED_TO_SURVIVE.cover?(cons.length)
      cons
    else
      []
    end
  end
end

