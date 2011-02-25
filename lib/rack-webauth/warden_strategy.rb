require 'rack-webauth'

unless defined?(Warden)
  raise "Can't define warden strategy, as Warden isn't available. Get it from https://github.com/hassox/warden/"
end

# Basic strategy for Warden, a authentication framework for Rack.
#
# For more information about warden, see https://github.com/hassox/warden/
#
# You can either use this "as is", which will give you a
# Rack::Webauth::User object to work with, or tie it to
# your own User objects, by setting the finder.
#
# See Rack::Webauth::WardenStrategy.finder for more information.
#
# For information on how to use this in Devise, see documentation
# of Rack::Webauth::WardenStrategy::InstanceMethods
#
class Rack::Webauth::WardenStrategy < Warden::Strategies::Base
  #
  # Actual functionality of WardenStrategy, so it can be used
  # within other classes as well, without the need to inherit
  # from Warden::Strategies::Base.
  #
  # Especially useful when using devise:
  #
  #   class MyWebauthStrategy < Devise::Strategies::Authenticatable
  #     include Rack::Webauth::WardenStrategy::InstanceMethods
  #
  #     self.finder = lambda {
  #       mapping.to.find_by_email(webauth.attributes['mail'])
  #     }
  #   end
  #
  # For more information about Devise see https://github.com/plataformatec/devise
  #
  module InstanceMethods
    def self.included(base)
      base.extend(ClassMethods)
    end

    include Rack::Webauth::Helpers

    def valid?
      webauth.logged_in?
    end

    def authenticate!
      if user = instance_eval(&self.class.finder)
        success!(user)
      else
        fail!(:invalid)
      end
    end
  end

  module ClassMethods
    def self.extended(base)
      class << base
        attr_writer :finder
      end
    end

    # Default user finder. By default initializes a
    # Rack::Webauth::User. You can set it to something
    # else:
    #
    #   Rack::Webauth::WardenStrategy.finder = lambda {
    #     MyUserModel.find_by_email_address(webauth.attributes['mail'])
    #   }
    #
    # The finder will be evaluated inside the strategy instance,
    # so you have access to "webauth", "env", ...
    def finder
      @finder ||= lambda {
        Rack::Webauth::User.new(webauth)
      }
    end
  end

  include(InstanceMethods)
end

Warden::Strategies.add(:webauth, Rack::Webauth::WardenStrategy)
