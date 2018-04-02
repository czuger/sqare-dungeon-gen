Gem::Specification.new do |s|
  s.name        = 'square-dungeon-gen'
  s.version     = '1.4.0'
  s.date        = '2018-03-13'
  s.summary     = 'Generate square dungeons'
  s.description = 'A simple gem that generate square dungeons'
  s.authors     = ['Cédric Zuger']
  s.email       = 'zuger.cedric@gmail.com'
  s.files       = Dir.glob('lib/**/*') + %w(README.md)
  s.homepage    =
      'https://github.com/czuger/sqare-dungeon-gen'
  s.license       = 'MIT'
  s.add_dependency 'hazard', '~> 1'
  s.add_dependency 'rmagick', '~> 2.16'
  s.add_dependency 'dd-next-encounters', '>= 2.0.0'
  s.required_ruby_version = '>= 2.3.6'
end