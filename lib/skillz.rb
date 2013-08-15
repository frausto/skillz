require 'active_support/all'
require 'skillz/player'
require 'skillz/team'
require 'skillz/match'

module Skillz
  INITIAL_SKILL_LEVEL = 25.0
  UNCERTAINTY = INITIAL_SKILL_LEVEL/3.0
  BETA = UNCERTAINTY*0.5
end

