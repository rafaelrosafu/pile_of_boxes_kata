class Pile
  attr_reader :boxes

  def initialize(*box_sizes)
    @height = nil
    @boxes = box_sizes.map {|box_size| Box.new(box_size)}
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
end
