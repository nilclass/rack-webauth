# -*- mode:ruby -*-
# Reference:
#   http://rubygems.rubyforge.org/rubygems-update/Gem/Specification.html
spec = Gem::Specification.new do |s|
  s.name = 'rack-webauth'
  s.version = '0.1.2'
  s.summary = 'Rack middleware to acquire authentication information froma "Stanford WebAuth system.'
  s.authors = ['Niklas E. Cathor']
  s.email = ['niklas@brueckenschlaeger.de']

  s.add_dependency 'rack'
  s.files = ['lib/rack-webauth.rb', 'README.textile', 'COPYING', 'COPYING.LESSER']
end
