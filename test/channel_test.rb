require_relative 'test_helper'

describe 'can create a channel' do
  let (:channel) {
    SlackCLI::Channel.new(01, "zadie", "cute puppies", 2)
  }
  it 'creates a channel' do
    expect(channel).must_be_instance_of SlackCLI::Channel
    expect(channel.topic).must_equal 'cute puppies'
  end
end

describe 'Channel.get' do
  
  before do
    VCR.use_cassette("channels.list") do
      query_parameters = {
        token: ENV['SLACK_KEY']
      }
      @channels_json = SlackCLI::Channel.get('https://slack.com/api/channels.list',query: query_parameters)
    end
  end
  
  it 'gets channel list from slack' do
    expect(@channels_json.code).must_equal 200
  end
  
  it "returns an array of channels" do
    expect(@channels_json["channels"]).must_be_kind_of Array
  end
end

describe 'json_parse' do
  before do
    VCR.use_cassette("channels.list") do
      query_parameters = {
        token: ENV['SLACK_KEY']
      }
      @channels_json = SlackCLI::Channel.get('https://slack.com/api/channels.list',query: query_parameters)
    end
    @channels = SlackCLI::Channel.json_parse(@channels_json)
  end
  
  it 'creates an array' do
    expect(@channels).must_be_kind_of Array
  end
  
  it 'creates an array of Channels' do
    expect(@channels[0]).must_be_instance_of SlackCLI::Channel
  end
end

