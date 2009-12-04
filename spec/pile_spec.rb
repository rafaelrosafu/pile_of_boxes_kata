require 'lib/pile.rb'

describe Pile do
  it "should have a height" do
    pile = Pile.new
    pile.height.should == 0
  end

  it "should receive a list of boxes" do
    pile = Pile.new(1,2,3)
    pile.boxes.should == [1,2,3]
  end
end

