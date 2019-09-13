require_relative 'test_helper'

describe 'class workspace' do
  
  let(:workspace){ Slack::Workspace.new }
  
  describe 'select_user' do
    it "must return an instance of Slack::User" do
      VCR.use_cassette("user_list_cassette") do
        selected_user = workspace.select_user(username: 'slackbot')
        expect(selected_user).must_be_instance_of Slack::User
      end
    end
    
    it "must raise Slack_Api_Error if if you provide neither a channel name or an id" do
      VCR.use_cassette("user_list_cassette") do
        expect{workspace.select_user}.must_raise Slack::Slack_Api_Error
      end
    end
    
    it "must raise an ArgumentError if no user matches the provided username or id" do
      VCR.use_cassette("user_list_cassette") do
        expect{workspace.select_user(username: 'dee')}.must_raise ArgumentError
        expect{workspace.select_user(id: '9banana')}.must_raise ArgumentError
      end
    end
    
    it "must give an accurate result regardless of which parameter is provided" do
      VCR.use_cassette("user_list_cassette") do
        selected_user_1 = workspace.select_user(username: 'slackbot')
        selected_user_2 = workspace.select_user(id: 'USLACKBOT')
        selected_user_3 = workspace.select_user(username: 'slackbot', id: 'USLACKBOT')
        
        expect(selected_user_1.name).must_equal 'slackbot'
        expect(selected_user_1.id).must_equal'USLACKBOT'
        expect(selected_user_1).must_equal selected_user_2
        expect(selected_user_1).must_equal selected_user_3
      end
    end
    
  end
  
  describe 'select_channel' do
    it "must return an instance of Slack::Channel" do
      VCR.use_cassette("channel_list_cassette") do
        selected_channel = workspace.select_channel(channel_name: 'random')
        expect(selected_channel).must_be_instance_of Slack::Channel
      end
    end
    
    it "must raise an error if the user provides neither a channel name or an id" do 
      VCR.use_cassette("channel_list_cassette") do
        expect{workspace.select_channel}.must_raise Slack::Slack_Api_Error
      end
    end
    
    it "must raise ArgumentError if no channel matches the provided channel name or id " do
      VCR.use_cassette("channel_list_cassette") do
        expect{workspace.select_channel(channel_name: 'lalala')}.must_raise ArgumentError
        expect{workspace.select_channel(id: 'lalala')}.must_raise ArgumentError
      end
    end
    
    it "must give an accurate result regardless of which parameter is provided" do 
      VCR.use_cassette("channel_list_cassette") do
        selected_channel_1 = workspace.select_channel(channel_name: 'random')
        selected_channel_2 = workspace.select_channel(id: "CN9FFLVEK")
        selected_channel_3 = workspace.select_channel(channel_name: 'random', id: "CN9FFLVEK")
        
        expect(selected_channel_1.name).must_equal "random"
        expect(selected_channel_1.id).must_equal "CN9FFLVEK"
        expect(selected_channel_1).must_equal selected_channel_2
        expect(selected_channel_1).must_equal selected_channel_3
      end
    end
    
  end
  
  describe "show details" do 
    it "must raise Slack_Api_Error if no recipient is selected" do 
      VCR.use_cassette("user_list_cassette") do
        expect{workspace.show_details}.must_raise Slack::Slack_Api_Error
      end
    end
    
    it "must return a hash" do
      VCR.use_cassette("channel_list_cassette") do
        selected_channel = workspace.select_channel(channel_name: 'random')
        expect(workspace.show_details).must_be_instance_of Hash
      end
      
      VCR.use_cassette("user_list_cassette") do
        selected_user = workspace.select_user(username: 'slackbot')
        expect(workspace.show_details).must_be_instance_of Hash
      end
    end
    
    it "must return the 5 details of a user if the selected recipient is a user" do 
      VCR.use_cassette("user_list_cassette") do
        selected_user = workspace.select_user(username: 'slackbot')
        expect(workspace.show_details.length).must_equal 5
        expect(workspace.show_details).must_equal selected_user.details
      end
    end
    
    it "must return the 4 details of a channel if the selected recipient is a channel" do
      VCR.use_cassette("channel_list_cassette") do 
        selected_channel = workspace.select_channel(channel_name: 'random')
        expect(workspace.show_details.length).must_equal 4
        expect(workspace.show_details).must_equal selected_channel.details
      end
    end
  end
  
  describe "send message" do 
    let(:channel_message){ "This is a Channel Message!" }
    
    let(:user_message){ "This is a User Message!" }
    
    it "must return a valid response" do
      VCR.use_cassette("user_list_cassette") do 
        selected_user = workspace.select_user(username: 'slackbot')
      end
      
      VCR.use_cassette("user_chat_post_cassette") do
        response = workspace.send_message(message: user_message)
        expect(response['ok']).must_equal true
      end
    end
    
    it "must raise a Slack_Api_Error if no recipient is currently selected" do
      VCR.use_cassette("no_recipient_error") do
        workspace_2 = Slack::Workspace.new
        expect{workspace_2.send_message(message: user_message)}.must_raise Slack::Slack_Api_Error
      end
    end
    
  end
  
end
