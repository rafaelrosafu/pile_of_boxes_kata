require 'lib/pile.rb'

describe Pile do
  it "should have a height" do
    pile = Pile.new
    pile.height.should == 0
  end
end

