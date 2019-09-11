require_relative 'test_helper'
require 'pry'

describe "Channel class" do
  before do
    BASE_URL = "https://slack.com/api/channels.list"
    TOKEN = ENV["SLACK_TOKEN"]
    @query = {
      token: TOKEN
    }
  end

  it "can create an instance of Channel" do
    VCR.use_cassette("channel_instantiation") do
      
      @response = HTTParty.get(BASE_URL, query: @query)

      id = "CJAMGE6R1"
      name = "random"
      topic = 
      member_count = "Slackbot"
      channel = Channel.new(id, name, topic, member_count)
      
      expect(user).must_be_instance_of Channel
    end
  end

  it "can return slackbot details" do
    VCR.use_cassette("channel_list_generation") do
      
      @response = HTTParty.get(BASE_URL, query: @query)
      binding.pry

    expect(@response["channels"][0]["id"]).must_equal "CJAMGE6R1"
    expect(@response["channels"][0]["name"]).must_equal "random"

    end
  end

end