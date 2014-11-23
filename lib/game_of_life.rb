module GameOfLife
  def self.transition_at_end_of_day(cons)
    if cons.length > 2
      cons
    else
      []
    end
  end
end

