Gem::Specification.new do |s|
  s.name        = 'square-dungeon-gen'
  s.version     = '1.0.0'
  s.date        = '2018-03-13'
  s.summary     = 'Generate dungeons'
  s.description = 'A simple gem that generate square dungeons'
  s.authors     = ['Cédric Zuger']
  s.email       = 'zuger.cedric@gmail.com'
  s.files       = ['lib/dungeon.rb']
  s.homepage    =
      'https://github.com/czuger/sqare-dungeon-gen'
  s.license       = 'MIT'
  s.add_dependency 'hazard'
  s.add_dependency 'rmagick'
end