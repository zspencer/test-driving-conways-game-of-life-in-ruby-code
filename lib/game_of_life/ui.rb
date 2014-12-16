class GameOfLife
  class UI
    def initialize(width, height)
      @width  = width
      @height = height
    end

    def draw(world)
      output = []
      (0...@width).each do |x|
        (0...@height).each do |y|
          char = world.include?({ :x =>x, :y => y}) ? "X" : " "
          output.push(char)
        end
      end
      output.join("\n")
    end
  end
end
