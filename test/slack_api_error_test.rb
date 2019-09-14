require_relative 'test_helper'

describe 'class slack_api_error' do 
  it "creates a new instance of Slack::Slack_Api_Error" do
    expect(Slack::Slack_Api_Error.new).must_be_instance_of Slack::Slack_Api_Error
  end
end