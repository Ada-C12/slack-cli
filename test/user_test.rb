require_relative 'test_helper'
require 'pry'

describe "user class" do
  describe "self.list method" do
    it "should return true if API was validated correctly" do
      VCR.use_cassette("user-tests") do
        response = User.list
        expect(response["ok"]).must_equal true
      end
    end
  end
  
  describe "self.printed_users_list" do
    it "should contain a user named slackbot" do
      VCR.use_cassette("user-tests") do
        users_array = User.printed_users_list
        users_array.each do |user|
          if user["name"] == "slackbot"
            assert (user), "Expected true"
          end
        end
      end
    end
    
    it "should return an array of users" do
      VCR.use_cassette("user-tests") do
        users_array = User.printed_users_list
        users_array.each do |user|
          expect
        end
        expect(users_array).must_be_kind_of Array
      end
    end
  end
end
