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

      id = "CN9N9ECF8"
      name = "random"
      topic = "Non-work banter and water cooler conversation"
      member_count = 2
      channel = Channel.new(id, name, topic, member_count)
      
      expect(channel).must_be_instance_of Channel
    end
  end

  it "can return channel details" do
    VCR.use_cassette("channel_list_generation") do
      
      @response = HTTParty.get(BASE_URL, query: @query)
      #binding.pry

    expect(@response["channels"][2]["id"]).must_equal "CN9N9ECF8"
    expect(@response["channels"][2]["name"]).must_equal "random"
    expect(@response["channels"][2]["topic"]["value"]).must_equal "Non-work banter and water cooler conversation"
    expect(@response["channels"][2]["num_members"]).must_equal 2
    end
  end

end