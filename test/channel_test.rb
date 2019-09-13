require_relative "test_helper"

describe "Channel class" do  
  describe "initialize method" do
    it "Initializes a new channel" do
      channel = SlackCLI::Channel.new(slack_id: 123, name: "test channel", topic: "tests", member_count: 10)
      
      expect(channel).must_be_instance_of SlackCLI::Channel
      expect(channel.slack_id).must_equal 123
      expect(channel.name).must_equal "test channel"
      expect(channel.topic).must_equal "tests"
      expect(channel.member_count).must_equal 10
    end
  end
  
  describe "get_message_history" do
    it "Gets message history for a channel" do
      VCR.use_cassette("channels") do
        all_channels = SlackCLI::Channel.all
        result = all_channels.first.get_message_history
        
        expect(result.code).must_equal 200
        expect(result["ok"]).must_equal true
      end
    end
  end
  
  describe "Self.all method" do
    it "Returns a list of all channels" do
      VCR.use_cassette("channels") do
        all_channels = SlackCLI::Channel.all
        
        expect(all_channels).must_be_instance_of Array
        expect(all_channels.length).must_equal 4
        
        all_channels.each do |channel|
          expect(channel).must_be_instance_of SlackCLI::Channel
        end
      end
    end
  end
end
