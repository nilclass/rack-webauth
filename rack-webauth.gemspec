# -*- mode:ruby -*-
# Reference:
#   http://rubygems.rubyforge.org/rubygems-update/Gem/Specification.html
spec = Gem::Specification.new do |s|
  s.name = 'rack-webauth'
  s.version = '0.1.3'
  s.summary = 'Rack middleware to acquire authentication information froma "Stanford WebAuth system.'
  s.authors = ['Niklas E. Cathor']
  s.email = ['niklas@brueckenschlaeger.de']

  s.add_dependency 'rack'
  s.add_development_dependency 'rspec'
  s.files = ['lib/rack-webauth.rb', 'README.textile', 'COPYING', 'COPYING.LESSER',
             'lib/rack-webauth/test.rb', 'lib/rack-webauth/warden_strategy.rb',
             'examples/test/config.ru']
end
