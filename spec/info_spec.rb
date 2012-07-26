require 'spec_helper'

describe Rack::Webauth::Info do
  subject { Rack::Webauth::Info.new @env }

  describe "logged in" do
    it "should be logged in when a WEBAUTH_USER is set" do
      @env = { "WEBAUTH_USER" => 'asdf' }

      subject.should be_logged_in
    end

    it "should be logged in when a REMOTE_USER is set" do
      @env = { "REMOTE_USER" => 'asdf' }

      subject.should be_logged_in
    end

    it "should not be logged in when neither WEBAUTH_USER or REMOTE_USER are set" do
      @env = { }

      subject.should_not be_logged_in
    end

    it "should not be logged in when WEBAUTH_USER is empty" do
      @env = { "WEBAUTH_USER" => "" }

      subject.should_not be_logged_in
    end

    it "should not be logged in when WEBAUTH_USER is <anonymous>" do
      @env = { "WEBAUTH_USER" => "<anonymous>" }

      subject.should_not be_logged_in
    end
  end
end
