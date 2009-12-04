class Pile
  attr_reader :boxes

  def initialize(*boxes)
    @height = 0
    @boxes = boxes
  end

  def height
    @height = boxes.first
  end
end

