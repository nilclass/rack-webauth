require 'rack-webauth'

# Middleware to use for testing in situations where WebAuth is not
# available, such as development environments.
#
# Example:
#   use(Rack::Webauth::Test,
#       :user => "test-user",
#       :mail => "someone@example.com")
#
#   use(Rack::Webauth)
#
#   run lambda {|env|
#     env["WEBAUTH_USER"] #=> "test-user"
#     env["WEBAUTH_LDAP_MAIL"] #=> "someone@example.com"
#     env[Rack::Webauth::NS].login #=> "test-user"
#     env[Rack::Webauth::NS].attributes['mail'] #=> "someone@example.com"
#   }
#
#
# In order to work correctly, Rack::Webauth::Test must come before
# Rack::Webauth in the middleware stack.
#
class Rack::Webauth::Test
  attr_reader :app, :env_vars

  def initialize(app, env_vars)
    @app, @env_vars = app, env_vars
  end

  def call(env)
    env_vars.each_pair do |key, value|
      add_to_env(env, key, value)
    end
    app.call(env)
  end

  private

  def add_to_env(env, key, value)
    normalized_key = key.to_s.upcase
    if %w(USER TOKEN_LASTUSED TOKEN_EXPIRATION
          LDAPAUTHRULE LDAPPRIVGROUP).include?(normalized_key)
      # regular setting
      env["WEBAUTH_#{normalized_key}"] = value
    elsif value.kind_of?(Array)
      # multi-valued LDAP attribute
      value.each_with_index do |val, index|
        env["WEBAUTH_LDAP_#{normalized_key}#{index + 1}"] = val
      end
    else
      # signle-valued LDAP attribute
      env["WEBAUTH_LDAP_#{normalized_key}"] = value
    end
  end
end
