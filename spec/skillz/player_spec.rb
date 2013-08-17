require 'spec_helper'

describe Skillz::Player do
  before do
    @now = Time.now
    Time.stub(:now => @now)
  end

  it "should increase uncertainty based on when the last match was played" do
    Skillz::Player.new(25, 5, @now - 60.days).skill_uncertainty.round(7).should == 5.7579173
  end

  it "does not adjust if inactive for less than 25 days" do
    Skillz::Player.new(25, 5, @now - 25.days).skill_uncertainty.round(7).should == 5
    Skillz::Player.new(25, 5, @now - 26.days).skill_uncertainty.round(7).should == 5.343775
  end

   it "time decay assumes 4 for sigma lower than 4" do
    smaller = Skillz::Player.new(25, 2, @now - 60.days).skill_uncertainty.round(7) - 2
    larger = Skillz::Player.new(25, 4, @now - 60.days).skill_uncertainty.round(7) - 4
    smaller.should == larger
  end

  it "time decay assumes 10 for sigma larger than 10" do
    smaller = Skillz::Player.new(25, 11, @now - 60.days).skill_uncertainty.round(7) - 11
    larger = Skillz::Player.new(25, 10, @now - 60.days).skill_uncertainty.round(7) - 10
    smaller.should == larger
    smaller = Skillz::Player.new(25, 13, @now - 13.days).skill_uncertainty.round(7) - 13
    larger = Skillz::Player.new(25, 10, @now - 13.days).skill_uncertainty.round(7) - 10
    smaller.should == larger
  end

end
