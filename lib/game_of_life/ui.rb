class GameOfLife
  class UI
    def initialize(width, height)
      @width  = width
      @height = height
    end

    def draw(world)
      output = []
      (0...@height).each do |y|
        row = []
        (0...@width).each do |x|
          row.push(char(world, { :x => x, :y => y }))
        end
        output.push(row.join(""))
      end
      output.join("\n")
    end

    private
    def char(world, location)
      world.include?(location) ? "X" : " "
    end
  end
end
