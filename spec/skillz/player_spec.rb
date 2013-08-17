require 'spec_helper'

describe Skillz::Player do
  it "should increase uncertainty based on when the last match was played" do
    now = Time.now
    Time.stub(:now => now)
    Skillz::Player.new(25, 4, now - 60.days).skill_uncertainty.round(7).should == 4.6063338
    Skillz::Player.new(25, 4, now - 10.days).skill_uncertainty.round(7).should == 4.1081014
  end
end
