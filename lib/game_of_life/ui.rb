class GameOfLife
  class UI
    def initialize(width, height)
      @width  = width
      @height = height
    end

    def draw(world)
      output = []
      output = (0...@height).reduce([]) do |output, y|
        row = (0...@width).reduce([]) do |row, x|
          row.push(char(world, { :x => x, :y => y }))
        end.join("")
        output.push(row)
      end
      output.join("\n")
    end

    private
    def char(world, location)
      world.include?(location) ? "X" : " "
    end
  end
end
