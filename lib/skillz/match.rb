module Skillz
  class Match

    def self.score(*teams)
      #set initial values
      teams.each{|t| t.uncertainty; t.skill_level}

      teams.each do |team1|
        omega = 0.0
        delta = 0.0
        teams.each do |team2|
          next if team1 == team2

          ciq = Math.sqrt(team1.uncertainty + team2.uncertainty + (2*Skillz::BETA*Skillz::BETA))
          piq = 1.0/(1+Math.exp((team2.skill_level-team1.skill_level)/ciq))
          sigsq_to_ciq = team1.uncertainty/ciq

          s = 0.0
          if team2.rank > team1.rank
            s = 1.0
          elsif team2.rank == team1.rank
            s = 0.5
          end

          omega += sigsq_to_ciq * (s-piq)
          gamma = Math.sqrt(team1.uncertainty)/ciq
          delta += gamma*sigsq_to_ciq/ciq*piq*(1-piq)
        end

        team1.players.map do |player|
          uncertainty_squared = player.skill_uncertainty**2
          player.skill_level += uncertainty_squared/team1.uncertainty * omega
          player.skill_uncertainty *= Math.sqrt([1 - uncertainty_squared / team1.uncertainty * delta, 0.0001].max)
          player
        end
      end
    end
  end
end
