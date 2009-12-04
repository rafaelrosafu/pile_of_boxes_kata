class Pile
  attr_reader :boxes

  def initialize(*box_sizes)
    @height = nil

    @boxes = [Box.new(box_sizes.shift)]
    box_sizes.each do |box_size|
      box = Box.new(box_size)
      begin
        @boxes.last.put(box)
      rescue Exception => error
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
  
  def depth
    sub_depth = @boxes_within.reduce(0) {|sum, box_within| sum += box_within.depth}
    @boxes_within.length + sub_depth
  end
  
  def put(smaller_box)
    puts "Colocando uma caixa tamanho #{smaller_box.size} dentro de #{size}"
    raise Error::BoxIsTooBig if smaller_box.size >= size
    raise Error::NotEnoughSpace if remaining_space < smaller_box.size

    if @boxes_within.empty? || !@boxes_within.last.can_fit?(smaller_box)
      @boxes_within << smaller_box
    else
      @boxes_within.last.put(smaller_box)
    end
  end
  
  private
    def occupied_space
      @boxes_within.reduce(0) do |sum, box_within|
        sum += box_within.size
      end
    end
end
