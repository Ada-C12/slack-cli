require_relative 'test_helper'

describe "channel instantiate" do 
  it "should instanitate as SlackCli::User" do
    @channel = SlackCli::Channel.new(name:"Sara", id: "6", topic:"general", num_members: "3")
    expect(@channel).must_be_kind_of SlackCli::Channel
  end 
end 

describe "channel list method should return correct values" do 
  it "all_users returns as an array with correct number of parameters" do 
    VCR.use_cassette("slack_details") do
      expect(SlackCli::Channel.list).must_be_kind_of Array
      expect(SlackCli::Channel.list.length).must_equal 3 
    end 
  end 

  it "channel list method returns correct name" do 
    VCR.use_cassette("slack_details") do
      expect(SlackCli::Channel.list[1][:name]).must_equal "random"
    end 
  end 

  it "user_hash contains name" do 
    VCR.use_cassette("slack_details") do
      expect(SlackCli::Channel.list[1][:topic]).must_be_kind_of String
    end 
  end 

  it "user_hash contains name" do 
    VCR.use_cassette("slack_details") do
      expect(SlackCli::Channel.list[1][:id]).must_equal "CN6CW5FBP"
    end
  end 

  it "user_hash contains id" do 
    VCR.use_cassette("slack_details") do
      expect(SlackCli::Channel.list[1][:num_members]).must_equal 2
      expect(SlackCli::Channel.list[1][:num_members]).must_be_kind_of Integer
    end 
  end 
end 