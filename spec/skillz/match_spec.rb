require 'spec_helper'

describe Skillz::Match do
  describe 'skill_level' do
    it "two new players play each other" do
      p1 = Skillz::Player.new
      p2 = Skillz::Player.new

      p1.skill_level.should == 25
      p2.skill_level.should == 25

      Skillz::Match.score(Skillz::Team.new([p1], 1), Skillz::Team.new([p2], 2))

      p1.skill_level.round(7).should == 27.6352314
      p2.skill_level.round(7).should == 22.3647686
    end

    it "high level loses to low level player" do
      p1 = Skillz::Player.new(30)
      p2 = Skillz::Player.new(10)

      p1.skill_level.should == 30
      p2.skill_level.should == 10

      Skillz::Match.score(Skillz::Team.new([p1], 2), Skillz::Team.new([p2], 1))

      p1.skill_level.round(7).should == 25.6770186
      p2.skill_level.round(7).should == 14.3229814
    end


    it "low level loses to high level player" do
      p1 = Skillz::Player.new(30)
      p2 = Skillz::Player.new(10)

      p1.skill_level.should == 30
      p2.skill_level.should == 10

      Skillz::Match.score(Skillz::Team.new([p1], 1), Skillz::Team.new([p2], 2))

      p1.skill_level.round(7).should == 30.9474814
      p2.skill_level.round(7).should == 9.0525186
    end
  end

  describe 'skill_uncertainty' do
    it "one ceratin player beats uncertain player" do
      p1 = Skillz::Player.new(25, 2.3)
      p2 = Skillz::Player.new(25, 10)

      p1.skill_level.should == 25
      p2.skill_level.should == 25
      p1.skill_uncertainty.should == 2.3
      p2.skill_uncertainty.should == 10

      Skillz::Match.score(Skillz::Team.new([p1], 1), Skillz::Team.new([p2], 2))

      p1.skill_level.round(7).should == 25.2235335
      p2.skill_level.round(7).should == 20.7744132
      p1.skill_uncertainty.round(7).should == 2.2978876
      p2.skill_uncertainty.round(7).should == 9.2146587
    end

    it "one unceratin player beats certain player" do
      p1 = Skillz::Player.new(25, 2.3)
      p2 = Skillz::Player.new(25, 10)

      p1.skill_level.should == 25
      p2.skill_level.should == 25
      p1.skill_uncertainty.should == 2.3
      p2.skill_uncertainty.should == 10

      Skillz::Match.score(Skillz::Team.new([p1], 2), Skillz::Team.new([p2], 1))

      p1.skill_level.round(7).should == 24.7764665
      p2.skill_level.round(7).should == 29.2255868
      p1.skill_uncertainty.round(7).should == 2.2978876
      p2.skill_uncertainty.round(7).should == 9.2146587
    end


    it "uncertain high level loses to certain low level player" do
      p1 = Skillz::Player.new(30, 9.9)
      p2 = Skillz::Player.new(10, 3)

      p1.skill_uncertainty.should == 9.9
      p2.skill_uncertainty.should == 3
      p1.skill_level.should == 30
      p2.skill_level.should == 10

      Skillz::Match.score(Skillz::Team.new([p1], 2), Skillz::Team.new([p2], 1))

      p1.skill_level.round(7).should == 23.0607762
      p2.skill_level.round(7).should == 10.6372106
      p1.skill_uncertainty.round(7).should == 9.5156031
      p2.skill_uncertainty.round(7).should == 2.9968199
    end


    it "uncertain high level wins against certain low level" do
      p1 = Skillz::Player.new(30, 9.9)
      p2 = Skillz::Player.new(10, 3)

      p1.skill_uncertainty.should == 9.9
      p2.skill_uncertainty.should == 3
      p1.skill_level.should == 30
      p2.skill_level.should == 10

      Skillz::Match.score(Skillz::Team.new([p1], 1), Skillz::Team.new([p2], 2))

      p1.skill_level.round(7).should == 31.2933587
      p2.skill_level.round(7).should == 9.8812343
      p1.skill_uncertainty.round(7).should == 9.5156031
      p2.skill_uncertainty.round(7).should == 2.9968199
    end

    it "certain high level loses to uncertain low level player" do
      p1 = Skillz::Player.new(30, 3)
      p2 = Skillz::Player.new(10, 9.9)

      p1.skill_uncertainty.should == 3
      p2.skill_uncertainty.should == 9.9
      p1.skill_level.should == 30
      p2.skill_level.should == 10

      Skillz::Match.score(Skillz::Team.new([p1], 2), Skillz::Team.new([p2], 1))

      p1.skill_level.round(7).should == 29.3627894
      p2.skill_level.round(7).should == 16.9392238
      p1.skill_uncertainty.round(7).should == 2.9968199
      p2.skill_uncertainty.round(7).should == 9.5156031
    end

    it "certain high level wins against uncertain low level player" do
      p1 = Skillz::Player.new(30, 3)
      p2 = Skillz::Player.new(10, 9.9)

      p1.skill_uncertainty.should == 3
      p2.skill_uncertainty.should == 9.9
      p1.skill_level.should == 30
      p2.skill_level.should == 10

      Skillz::Match.score(Skillz::Team.new([p1], 1), Skillz::Team.new([p2], 2))

      p1.skill_level.round(7).should == 30.1187657
      p2.skill_level.round(7).should == 8.7066413
      p1.skill_uncertainty.round(7).should == 2.9968199
      p2.skill_uncertainty.round(7).should == 9.5156031
    end
  end
end
