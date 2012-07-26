require 'bundler/setup'

if ENV['COVERAGE'] and RUBY_VERSION =~ /^1.9/
  require 'simplecov'

  SimpleCov.start
end

require 'rspec/autorun'
require 'rack-webauth'

RSpec.configure do |config|

end

