class GameOfLife
  class UI
    def initialize(width, height)
      @width  = width
      @height = height
    end

    def draw(world)
      output = ["X"]
      output.join("\n")
    end
  end
end
