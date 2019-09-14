require_relative "test_helper"

describe Slack do
  it "sends message to the user" do
    VCR.use_cassette("message_user") do
      response = Slack.send_msg("Hello!!", "UMURAL35H")
      expect(response).must_equal true 
    end
  end

  it "sends message to the channel" do
    VCR.use_cassette("message_channel") do
      response = Slack.send_msg("Goodbye!", "sploots")
      expect(response).must_equal true 
    end  
  end #end send message
end