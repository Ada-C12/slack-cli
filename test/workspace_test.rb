require_relative 'test_helper'
require 'pry'

describe "Workspace class" do
    # BASE_URL = "https://slack.com/api/"
    # TOKEN = ENV["SLACK_TOKEN"]
  before do
 
    # @query = {
    #   token: TOKEN
    # }
  end

  it "can create an instance" do
    VCR.use_cassette("user_list_generation") do
      
      user = Workspace.new
      
      expect(user).must_be_instance_of Workspace
      #expect(user.id).must_equal "USLACKBOT"
    end
  end

  it "can return list of users" do
    VCR.use_cassette("user_list_generation") do

      workspace = Workspace.new
      users = workspace.users
  
    expect(users[0].id).must_equal "USLACKBOT"
    expect(users[0].name).must_equal "slackbot"
    expect(users[0].real_name).must_equal "Slackbot"
    end
  end

  it "can return channel details" do
    VCR.use_cassette("channel_list_generation") do
      workspace = Workspace.new
      channels = workspace.channels

    expect(channels[2].id).must_equal "CN9N9ECF8"
    expect(channels[2].name).must_equal "random"
    expect(channels[2].topic).must_equal "Non-work banter and water cooler conversation"
    expect(channels[2].member_count).must_equal 2
    end
  end

  it "can return channel details" do
    VCR.use_cassette("channel_list_generation") do
      workspace = Workspace.new
      channels = workspace.channels

    expect(channels[2].id).must_equal "CN9N9ECF8"
    expect(channels[2].name).must_equal "random"
    expect(channels[2].topic).must_equal "Non-work banter and water cooler conversation"
    expect(channels[2].member_count).must_equal 2
    end
  end

end