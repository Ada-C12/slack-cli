require_relative 'test_helper'

describe "Channel class" do

  it "can create an instance of Channel" do
    VCR.use_cassette("channel_instantiation") do

      id = "CN9N9ECF8"
      name = "random"
      topic = "Non-work banter and water cooler conversation"
      member_count = 2
      channel = Channel.new(id, name, topic, member_count)
      
      expect(channel).must_be_instance_of Channel
    end
  end
end