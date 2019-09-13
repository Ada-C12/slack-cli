# require_relative '../lib/recipient'
require_relative 'test_helper'


describe "SlackCLI::User" do
  describe "list" do
    it "should be a list of user objects" do
      VCR.use_cassette("list_users") do
        expect(SlackCLI::User.list.first).must_be_instance_of SlackCLI::User
      end
    end
  end
  
  it "should return an Array" do
    VCR.use_cassette("list_users") do
      expect(SlackCLI::User.list).must_be_instance_of Array
    end
  end  
end
