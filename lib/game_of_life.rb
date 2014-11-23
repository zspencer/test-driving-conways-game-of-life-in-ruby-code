module GameOfLife
  def self.next_day(cons)
    if cons.length > 2 && cons.length < 4
      cons
    else
      []
    end
  end
end

