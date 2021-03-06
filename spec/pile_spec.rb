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

  context "given no permeability" do
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
        pile = Pile.new(2,1)
        pile.height.should == 2
      end

      it "with sizes 2 and 3, it should have a height of 5" do
        pile = Pile.new(2,3)
        pile.height.should == 5
      end
    end

    context "given 3 boxes" do
      it "with sizes 1, 1 and 2, it should have a height of 4" do
        pile = Pile.new(1,1,2)
        pile.height.should == 4
      end

      it "with sizes 1, 3 and 2, it should have a height of 4" do
        pile = Pile.new(1,3,2)
        pile.height.should == 4
      end

      it "with sizes 1, 3 and 5, it should have a height of 9" do
        pile = Pile.new(1,3,5)
        pile.height.should == 9
      end

      it "with sizes 3, 2 and 2, it should have a height of 5" do
        pile = Pile.new(3,2,2)
        pile.height.should == 5
      end
    end
  end
  
  context "given permeability" do
    context "given 3 boxes" do
      context "with sizes 3, 2 and 1" do
        before :each do
          @pile = Pile.new(3,2,1)
        end
        it "should have a height of 3" do
          @pile.height.should == 3
        end

        it "the first box should have 1 box inside" do
          @pile.boxes.first.boxes_within.length.should == 1
        end

        it "the first box depth should be 2" do
          @pile.boxes.first.depth.should == 2
        end
      end
    end

    context "given 4 boxes" do
      context "with sizes 4, 3, 2 and 1" do
        before :each do
          @pile = Pile.new(4,3,2,1)
        end
        it "should have a height of 4" do
          @pile.height.should == 4
        end

        it "the first box should have 1 box inside" do
          @pile.boxes.first.boxes_within.length.should == 1
        end

        it "the first box depth should be 3" do
          @pile.boxes.first.depth.should == 3
        end
      end
    end

    context "given 5 boxes" do
      context "with sizes 2, 3 and 1" do
        before :each do
          @pile = Pile.new(2,3,1)
        end

        it "should have a height of 5" do
          @pile.height.should == 5
        end

        it "should have one box inside de first box" do
          pending
          @pile.boxes.first.boxes_within.length.should == 1
        end
      end
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
      lambda { @box.put(box_within) }.should raise_error(Box::Error::BoxIsTooBig)
    end

    it "should return an error if there's no more space within it" do
      @box.put(Box.new(2))
      lambda { @box.put(Box.new(3)) }.should raise_error(Box::Error::NotEnoughSpace)
    end
  end
  
  context "when asked about the remaining space inside of it" do 
    it "when empty it should be equal its height when created" do
      box = Box.new(3)
      box.remaining_space.should == 3
    end

    it "when it contains a box, it should be its height minus the sum of the height of the boxes within" do
      box = Box.new(3)
      box.put(Box.new(1))
      box.put(Box.new(1))
      box.remaining_space.should == 1
    end
  end

  context "when asked if it can fit a given box" do
    before :each do
      @box = Box.new(3)
    end

    context "should respond true" do
      it "if it has remaining space" do
        smaller_box = Box.new(2)
        @box.can_fit?(smaller_box).should be_true
      end

      it "if it's bigger than the received box" do
        smaller_box = Box.new(2)
        @box.can_fit?(smaller_box).should be_true
      end
    end

    context "should respond false" do
      it "if it doesn't have remaining space" do
        smaller_box = Box.new(2)
        @box.put(smaller_box)
        @box.can_fit?(smaller_box).should be_false
      end

      it "if it's smaller than the received box" do
        bigger_box = Box.new(4)
        @box.can_fit?(bigger_box).should be_false
      end

      it "if it's of equal size to the received box" do
        equal_box = Box.new(3)
        @box.can_fit?(equal_box).should be_false
      end
    end
  end
end
