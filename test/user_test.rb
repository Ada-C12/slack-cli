require_relative 'test_helper'
require 'awesome_print'

describe "User" do
  before do
    @user = Slack::User.new(username: "spengler", real_name: "Bob Spengler", slack_id: "W012A3CDE")
    VCR.use_cassette("user") do 
      @response = @user.get_api
      @list = @user.list
    end
  end

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
      # user = Slack::User.new(username: "spengler", real_name: "Bob Spengler", slack_id: "W012A3CDE")
      # VCR.use_cassette("user") do 
      #   @response = user.get_api
      # end
      expect(@response).must_be_kind_of HTTParty::Response
      expect(@response["members"]).must_be_kind_of Array
      expect(@response["members"][0]["name"]).wont_be_nil
      expect(@response["members"][0]["real_name"]).wont_be_nil
      expect(@response["members"][0]["id"]).wont_be_nil
    end
  end

  describe ".list" do
    it "returns an array of User objects" do
      expect(@list).must_be_kind_of Array
      expect(@list[0]).must_be_instance_of Slack::User
    end

    it "returns an array with the correct length" do
      expect(@list.length).must_equal 7
    end
    
  end
  
  
  


















end