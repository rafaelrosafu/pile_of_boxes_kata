require 'lib/pile.rb'

describe Pile do
  it "should have a height" do
    pile = Pile.new
    pile.should respond_to(:height)
  end

  it "should receive a list of boxes" do
    pile = Pile.new(1,2,3)
    pile.boxes.should == [1,2,3]
  end

  context "given 1 box" do
    it "with size 1, it should have a height of 1" do
      pile = Pile.new(1)
      pile.height.should == 1
    end

    it "with size 1, it should have a height of 5" do
      pile = Pile.new(5)
      pile.height.should == 5
    end
  end

  context "given 2 boxes" do
    it "with sizes 1 and 2, it should have a height of 3" do
      pile = Pile.new(1,2)
      pile.height.should == 3
    end
  end
end

