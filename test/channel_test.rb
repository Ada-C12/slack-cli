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

  describe "channel.get" do
    it "gets response from server (JSON)" do
      VCR.use_cassette("channel") do
        #Arrange
        url = "https://slack.com/api/channels.list"
        query = {token: ENV['SLACK_TOKEN']}
        #Act
        response = User.get(url, query)

        #Assert
        expect(response).must_be_instance_of HTTParty::Response
      end
    end
  end


  describe "self.list" do
    it "returns a new channel's list" do
      VCR.use_cassette("channel") do
        #Act
        list = Channel.list
        #Assert
        expect(list).must_be_kind_of Array
        expect(list.length).must_equal 5
      end
    end

    it "Returns accurate information about the first channel" do
      VCR.use_cassette("channel") do
        topic = {
          "value" => "Non-work banter and water cooler conversation",
          "creator" => "UMTGXDXD0",
          "last_set" => 1568073948
        }
        first = Channel.list.first
        expect(first.slack_id).must_equal "CN5S0B30U"
        expect(first.name).must_equal "random"
        expect(first.topic).must_equal topic
        expect(first.member_count).must_equal 4
      end
    end

    it "Returns accurate information about the last channel" do
      VCR.use_cassette("channel") do
        topic = {
          "value" => "",
          "creator" => "",
          "last_set" => 0
        }
        last = Channel.list.last
        expect(last.slack_id).must_equal "CNANHC6LF"
        expect(last.name).must_equal "spaghetti"
        expect(last.topic).must_equal topic
        expect(last.member_count).must_equal 3
      end
    end
  end
end

    
    