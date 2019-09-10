require_relative "test_helper"
require 'dotenv'
require 'httparty'

Dotenv.load

describe "Channel" do
  before do
    slack_id = "1232452"
    name = "Random"
    topic = "Ada"
    member_count = "3"

    @channel = Channel.new(name, topic, member_count, slack_id)
  end

  describe "Channel instantiation" do
    it "creates an instance of Channel" do
      expect(@channel).must_be_kind_of Channel 
    end
  end
end

    
    