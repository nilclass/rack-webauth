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

  describe "#attributes" do
    it "should manipulate ENV into a ruby hash" do
      @env = {
        'WEBAUTH_LDAP_FOO'  => "x",
        'WEBAUTH_LDAP_FOO1' => "x",
        'WEBAUTH_LDAP_FOO2' => "y",
        'WEBAUTH_LDAP_BAR'  => "z"
      }

      subject.attributes.should == { 'FOO' => ['x', 'y'], 'BAR' => 'z' }
    end
  end

  describe "#privgroup" do
    it "should be the WEBAUTH_LDAPPRIVGROUP" do
      @env = { 'WEBAUTH_LDAPPRIVGROUP' => (mock_group = mock()) }
      subject.privgroup.should == mock_group
    end
  end

  describe "#authrule" do
    it "should be the WEBAUTH_LDAPAUTHRULE" do
      @env = { 'WEBAUTH_LDAPAUTHRULE' => (mock_group = mock()) }
      subject.authrule.should == mock_group
    end
  end

  describe "#token_creation" do
    it "should be the time when the auth cookie was created" do
      t =  Time.new("2009-02-13 15:31:30 -0800")
      @env = { 'WEBAUTH_TOKEN_CREATION' => t.to_i.to_s }
      subject.token_creation.should == t
    end
  end

  describe "#token_expiration" do
    it "should be the time when the auth cookie will expire" do
      t =  Time.new("2009-02-13 15:31:30 -0800")
      @env = { 'WEBAUTH_TOKEN_EXPIRATION' => t.to_i.to_s }
      subject.token_expiration.should == t
    end
  end

  describe "#token_lastused" do
    it "should be the time when the auth cookie was last used" do
      t =  Time.new("2009-02-13 15:31:30 -0800")
      @env = { 'WEBAUTH_TOKEN_LASTUSED' => t.to_i.to_s }
      subject.token_lastused.should == t
    end
  end
end
