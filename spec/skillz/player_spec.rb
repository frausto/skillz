require 'spec_helper'

describe Skillz::Player do
  it "should increase uncertainty based on when the last match was played" do
    now = Time.now
    Time.stub(:now => now)
    Skillz::Player.new(25, 5, now - 60.days).skill_uncertainty.round(7).should == 5.7579173
    Skillz::Player.new(25, 5, now - 10.days).skill_uncertainty.round(7).should == 5.1351268
  end

   it "time decay assumes 4 for sigma lower than 4" do
    now = Time.now
    Time.stub(:now => now)
    smaller = Skillz::Player.new(25, 2, now - 60.days).skill_uncertainty.round(7) - 2
    larger = Skillz::Player.new(25, 4, now - 60.days).skill_uncertainty.round(7) - 4
    smaller.should == larger
  end

  it "time decay assumes 10 for sigma larger than 10" do
    now = Time.now
    Time.stub(:now => now)
    smaller = Skillz::Player.new(25, 11, now - 60.days).skill_uncertainty.round(7) - 11
    larger = Skillz::Player.new(25, 10, now - 60.days).skill_uncertainty.round(7) - 10
    smaller.should == larger
    smaller = Skillz::Player.new(25, 13, now - 13.days).skill_uncertainty.round(7) - 13
    larger = Skillz::Player.new(25, 10, now - 13.days).skill_uncertainty.round(7) - 10
    smaller.should == larger
  end

end
