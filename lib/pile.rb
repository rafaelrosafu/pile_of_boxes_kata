class Pile
  attr_reader :boxes

  def initialize(*box_sizes)
    @height = nil

    @boxes = [Box.new(box_sizes.shift)]
    box_sizes.each do |box_size|
      @boxes << Box.new(box_size)
    end
    @boxes
  end

  def height
    @height ||= boxes.reduce(0) do |sum, box|
      sum += box.size
    end
  end
end

class Box
  attr_reader :size

  def initialize(size)
    @size = size
  end
  
  def remaining_space
    @size
  end
end
