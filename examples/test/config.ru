# -*- mode:ruby -*-

$: << '../../lib/'
require 'rack-webauth/test'

use Rack::Webauth::Test, :user => "nilclass", :mail => "niklas@brueckenschlaeger.de"

use Rack::Webauth

run lambda { |env|
  user = Rack::Webauth::User.new(env[Rack::Webauth::NS])

  $stderr.puts "LOGIN: #{user.login}"
  $stderr.puts "MAIL: #{user[:mail]}"
  [200, { "Content-Type" => "text/html" },
   ['<h1>', "All fine. Check logs.", '</h1>',
    '<pre>', env.inspect,'</pre>']]
}
