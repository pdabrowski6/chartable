lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chartable/version'

Gem::Specification.new do |s|
  s.add_runtime_dependency 'activesupport', '>= 3.0.0'
  s.add_runtime_dependency 'chronic', '~> 0.10'
  s.add_development_dependency "rspec", '~> 3.7', '>= 3.7.0'
  s.name        = 'chartable'
  s.version     = Chartable::Version
  s.date        = '2018-04-25'
  s.summary     = "A lightweight and database-level library to transform any Active Record query into analytics data ready for any chart"
  s.description = "A lightweight and database-level library to transform any Active Record query into analytics data ready for any chart"
  s.authors     = ["Paweł Dąbrowski"]
  s.email       = 'dziamber@gmail.com'
  s.files       = Dir['lib/**/*.rb', 'spec/helper.rb']
  s.homepage    =
    'http://github.com/rubyhero/chartable'
  s.license       = 'MIT'
  s.add_development_dependency "activerecord", '>= 4.0.0'
  s.add_development_dependency "mysql2", '~> 0'
  s.add_development_dependency "timecop", '~> 0'
  s.add_development_dependency "factory_bot_rails", '>= 4.0.0'
  s.add_development_dependency "database_cleaner", '>= 1.0.0'
  s.required_ruby_version = '>= 2.1.0'
end
