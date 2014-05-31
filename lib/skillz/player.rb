module Skillz
  class Player

    attr_accessor :skill_level, :skill_uncertainty, :data

    def initialize(skill_level=nil, uncertainty=nil, last_match_time=nil, data={})
      @skill_level = skill_level || Skillz::INITIAL_SKILL_LEVEL
      @skill_uncertainty = uncertainty || Skillz::UNCERTAINTY
      @data = data || {}
      adjust_for_inactivity(last_match_time) if last_match_time
    end

    def adjusted_skill_level
      @skill_level - (@skill_uncertainty * 0.5)
    end

    private

    def adjust_for_inactivity(last_match_time)
      days = (Time.now - last_match_time).to_i / (24 * 60 * 60)
      return if days <= 25
      time_decay = 1 - Math.exp((days * -1.0)/365)
      time_decay *= [[skill_uncertainty, 4].max, 10].min
      @skill_uncertainty += time_decay
    end
  end
end
