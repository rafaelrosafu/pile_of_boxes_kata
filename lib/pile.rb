class Pile
  attr_reader :boxes

  def initialize(*boxes)
    @height = nil
    @boxes = boxes
  end

  def height
    @height ||= boxes.reduce(0) do |sum, box|
      sum += box
    end
  end
end

