require_relative 'test_helper'

describe 'can create a user' do
  let (:user) {
    SlackCLI::User.new(35, "zadie", "Zadie Rose", "napping")
  }
  it 'creates a user' do
    expect(user).must_be_instance_of SlackCLI::User
    expect(user.status_text).must_equal 'napping'
  end
end

describe 'User.get' do
  
  before do
    VCR.use_cassette("users.list") do
      query_parameters = {
        token: ENV['SLACK_KEY']
      }
      @users_json = SlackCLI::Channel.get('https://slack.com/api/users.list', query: query_parameters)
    end
  end
  
  it 'gets user list from slack' do
    expect(@users_json.code).must_equal 200
  end
  
  it "returns an array of users" do
    expect(@users_json["members"]).must_be_kind_of Array
  end
end

describe 'User.json_parse' do
  before do
    VCR.use_cassette("users.list") do
      query_parameters = {
        token: ENV['SLACK_KEY']
      }
      @users_json = SlackCLI::User.get('https://slack.com/api/users.list',query: query_parameters)
    end
    @users = SlackCLI::User.json_parse(@users_json)
  end
  
  it 'creates an array' do
    expect(@users).must_be_kind_of Array
  end
  
  it 'creates an array of Users' do
    expect(@users[0]).must_be_instance_of SlackCLI::User
  end
  
  describe 'User.send_message' do 
    before do 
      @workspace = 
      VCR.use_cassette("workspace.new") do
        SlackCLI::Workspace.new
      end
      @slackbot = @workspace.select_user("Slackbot")
      @msg = VCR.use_cassette("send_msg_to_Slackbot") do
        @slackbot.send_message("hot potato")
      end    
    end 
    
    it "sends a message" do 
      expect(@msg.code).must_equal 200
    end 
  end
end 


