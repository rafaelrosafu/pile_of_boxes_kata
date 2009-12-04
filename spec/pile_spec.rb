require 'lib/pile.rb'

describe Pile do
  it "should have a height" do
    pile = Pile.new
    pile.should respond_to(:height)
  end

  it "should receive a list of boxes" do
    pile = Pile.new(1,2,3)
    pile.boxes.should be_a(Array)
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

    it "with sizes 1 and 1, it should have a height of 2" do
      pile = Pile.new(1,1)
      pile.height.should == 2
    end

    it "with sizes 2 and 1, it should have a height of 2" do
      pending
      pile = Pile.new(2,1)
      pile.height.should == 2
    end
  end
end

describe Box do
  it "should have its size given by the initializer" do
    box = Box.new(1)
    box.size.should == 1
  end

  context "when receiving boxes to put within" do  
    before :each do
      @box = Box.new(4)
    end

    it "should be able put them into and return a list containing it" do
      box_within = Box.new(2)
      @box.put(box_within)
      @box.boxes_within.should == [box_within]
    end
    
    it "should return an error if the received box size is bigger or equal than itself" do
      box_within = Box.new(5)
      lambda { @box.put(box_within) }.should raise_error
    end
  end
  
  context "when asked about the remaining space inside of it" do 
    it "when empty it should be equal its height when created" do
      box = Box.new(3)
      box.remaining_space.should == 3
    end

    it "when it contains a box, it should be its height minus the box within" do
      pending
      box = Box.new(3)
      box.put(Box.new(1))
      box.remaining_space.should == 2
    end
  end
end
