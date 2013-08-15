module Skillz
  class Team

    attr_accessor :rank, :players

    def initialize(players, rank=nil)
      @players = players
      @rank = rank if rank.present?
    end

    def skill_level
      @score ||= @players.map(&:skill_level).sum
    end

    def uncertainty
      @uncertainty_squared ||= begin
        @players.map do |player|
          player.uncertainty_in_skill_level * player.uncertainty_in_skill_level
        end.sum
      end
    end
  end
end
