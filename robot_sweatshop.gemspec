Gem::Specification.new do |gem|
  gem.name        = 'robot_sweatshop'
  gem.version     = '1.0.1'
  gem.licenses    = 'MIT'
  gem.authors     = ['Justin Scott']
  gem.email       = 'jvscott@gmail.com'
  gem.homepage    = 'http://robotsweat.com'
  gem.summary     = 'Robot Sweatshop'
  gem.description = 'A lightweight, nonopinionated CI server.'

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- test/**/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.required_ruby_version = '>= 2.1'

  gem.add_runtime_dependency 'faker'
  gem.add_runtime_dependency 'commander'
  gem.add_runtime_dependency 'eye'
  gem.add_runtime_dependency 'terminal-announce'
  gem.add_runtime_dependency 'configatron'
  gem.add_runtime_dependency 'contracts'
  gem.add_runtime_dependency 'sinatra'
  gem.add_runtime_dependency 'sinatra-cross_origin'
  gem.add_runtime_dependency 'ezmq'
  gem.add_runtime_dependency 'stubborn_queue'
  gem.add_runtime_dependency 'oj'
  gem.add_runtime_dependency 'exponential-backoff'
  gem.add_runtime_dependency 'erubis'
  gem.add_runtime_dependency 'sweatshop_gears'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'kintama'
  gem.add_development_dependency 'http'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'nokogiri'
end
