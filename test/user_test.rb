require_relative 'test_helper'
require 'awesome_print'

describe "User" do
  describe "initialize" do
    it "establishes the base attributes when instantiated" do
      user = Slack::User.new(username: "spengler", real_name: "Bob Spengler", slack_id: "W012A3CDE")
      [:username, :real_name, :slack_id].each do |attribute|
        expect(user).must_respond_to attribute
      end
    end
  end

  describe ".get_api" do 
    it "returns a instance of HTTParty::Response" do
      user = Slack::User.new(username: "spengler", real_name: "Bob Spengler", slack_id: "W012A3CDE")
      VCR.use_cassette("user") do 
        @response = user.get_api
      end
      expect(@response).must_be_kind_of HTTParty::Response
      expect(@response["members"]).must_be_kind_of Array
      expect(@response["members"][0]["name"]).wont_be_nil
      expect(@response["members"][0]["real_name"]).wont_be_nil
      expect(@response["members"][0]["id"]).wont_be_nil
    end


  end

  


















end