require 'spec_helper'

describe Skillz::Player do
  before do
    @now = Time.now
    Time.stub(:now => @now)
  end

  it "should increase uncertainty based on when the last match was played" do
    Skillz::Player.new(25, 5, @now - 60.days).skill_uncertainty.round(3).should == 5.758
  end

  it "does not adjust if inactive for less than 25 days" do
    Skillz::Player.new(25, 5, @now - 25.days).skill_uncertainty.round(3).should == 5
    Skillz::Player.new(25, 5, @now - 26.days).skill_uncertainty.round(3).should == 5.344
  end

   it "time decay assumes 4 for sigma lower than 4" do
    smaller = Skillz::Player.new(25, 2, @now - 60.days).skill_uncertainty.round(3) - 2
    larger = Skillz::Player.new(25, 4, @now - 60.days).skill_uncertainty.round(3) - 4
    smaller.round(3).should == larger.round(3)
  end

  it "time decay assumes 10 for sigma larger than 10" do
    smaller = Skillz::Player.new(25, 11, @now - 60.days).skill_uncertainty.round(3) - 11
    larger = Skillz::Player.new(25, 10, @now - 60.days).skill_uncertainty.round(3) - 10
    smaller.should == larger
    smaller = Skillz::Player.new(25, 13, @now - 13.days).skill_uncertainty.round(3) - 13
    larger = Skillz::Player.new(25, 10, @now - 13.days).skill_uncertainty.round(3) - 10
    smaller.should == larger
  end

  it "sets a data" do
    one = Skillz::Player.new(25, 11).data.should_not be_present
    two = Skillz::Player.new(25, 10, nil, {:id => 5}).data.should == {:id => 5}
  end
end
