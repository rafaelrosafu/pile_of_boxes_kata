class Pile
  attr_reader :boxes

  def initialize(*box_sizes)
    @height = nil

    @boxes = [Box.new(box_sizes.shift)]
    box_sizes.each do |box_size|
      box = Box.new(box_size)
      if @boxes.last.can_fit?(box)
        @boxes.last.put(box) 
      else
        @boxes << box
      end
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
  module Error
    class BoxIsTooBig < Exception
    end
    class NotEnoughSpace < Exception
    end
  end

  attr_reader :size, :boxes_within

  def initialize(size)
    @size = size
    @boxes_within = []
  end
  
  def remaining_space
    @size - occupied_space
  end
  
  def can_fit?(box)
    (size > box.size) && (remaining_space >= box.size)
  end
  
  def put(smaller_box)
    raise Error::BoxIsTooBig if smaller_box.size >= size
    raise Error::NotEnoughSpace if remaining_space < smaller_box.size
    @boxes_within << smaller_box
  end
  
  private
    def occupied_space
      @boxes_within.reduce(0) do |sum, box_within|
        sum += box_within.size
      end
    end
end
