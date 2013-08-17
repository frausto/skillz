# Skillz

Skillz is a Competitive Ranking System based upon others such as [TrueSkill](http://research.microsoft.com/en-us/projects/trueskill/details.aspx) among others. 

## Getting Started

Add this line to your application's Gemfile:

    gem 'skillz'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install skillz

## Usage

  example

    # create players where 30 is their average score
    # 4 is the level of uncertainty of their skill
    # and the last is how long its been since their last match
    # skill_level defaults to 25, and uncertainty defaults to skill_level/3
    # if no last played time is given it ignores it 

    p1 = Skillz::Player.new(30, 4, Time.now - 4.days)
    p2 = Skillz::Player.new(30, 4, Time.now - 20.days)
    p3 = Skillz::Player.new
    p4 = Skillz::Player.new

    # create teams with the players you want in each, and their ranking
    # as the second argument

    team1 = Skillz::Team.new([p1, p2], 1)
    team2 = Skillz::Team.new([p3, p4], 2)

    Skillz::Match.score(Skillz::Team.new([p1, p2], 1), Skillz::Team.new([p2], 2))
    # players are now update with their new skill_level and skill_uncertainty

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
6. Feel satisfied.
