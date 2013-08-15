module Skillz
  class Player

    attr_accessor :skill_level, :uncertainty_in_skill_level, :number_of_past_matches

    def initialize(skill_level=nil, uncertainty=nil, past_matches=nil)
      @skill_level = skill_level || Skillz::INITIAL_SKILL_LEVEL
      @uncertainty_in_skill_level = uncertainty || Skillz::UNCERTAINTY
      @number_of_past_matches = past_matches || 0
    end
  end
end
