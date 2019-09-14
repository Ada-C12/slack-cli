require_relative 'test_helper'

describe 'class recipient' do
  describe 'initialize' do 
    let(:recipient){Slack::Recipient.new(id: "CN9FFLVEK", name: "random")}
    
    it 'creates a new instance of Recipient' do
      expect(recipient).must_be_instance_of Slack::Recipient
    end
    
    it 'accurately stores slack_id' do
      expect(recipient.id).must_be_instance_of String
      expect(recipient.id).must_equal "CN9FFLVEK"
    end
    
    it 'accurately stores name' do
      expect(recipient.name).must_be_instance_of String
      expect(recipient.name).must_equal "random"
    end
  end
  
  describe 'self.get' do    
    it 'should return an instance of HTTParty::Response' do
      VCR.use_cassette("user_list_cassette") do
        url = "https://slack.com/api/users.list"
        params = {token: ENV["SLACK_TOKEN"]}
        response = Slack::Recipient.get(url, params)
        expect(response).must_be_instance_of HTTParty::Response
        expect(response["ok"]).must_equal true
      end
    end
    
    it 'should raise a Slack_Api_Error if the response code is not 200 or response is false' do
      VCR.use_cassette("response_code_error_cassette") do
        expect{Slack::Recipient.get("https://us1.locationiq.org/v1/search.php?", {token: ENV["SLACK_TOKEN"]})}.must_raise Slack::Slack_Api_Error
      end
      
      VCR.use_cassette("false_response_cassette") do
        expect{Slack::Recipient.get("https://slack.com/api/users.list", {token: "XXXXXXXX"})}.must_raise Slack::Slack_Api_Error
      end
    end
  end
  
  describe "self.list" do
    it "must raise NotImplementedError" do 
      expect{Slack::Recipient.list}.must_raise NotImplementedError
    end
  end
  
  describe "details" do
    it "must raise NotImplementedError" do
      tester = Slack::Recipient.new(name: "Xinran" , id: "1234")
      expect{tester.details}.must_raise NotImplementedError
    end
  end
  
  describe "send_message" do 
    let(:channel_recipient){Slack::Recipient.new(id: "CN9FFLVEK", name: "random")}
    
    let(:user_recipient){Slack::Recipient.new(id: "USLACKBOT", name: "slackbot")}
    
    let(:channel_message){"This is a Channel Message!"}
    
    let(:user_message){"This is a User Message!"}
    
    it "must return a respsonse" do 
      VCR.use_cassette("channel_chat_post_cassette") do
        expect(channel_recipient.send_message(channel_message)).must_be_instance_of HTTParty::Response
      end
      
      VCR.use_cassette("user_chat_post_cassette") do
        expect(user_recipient.send_message(user_message)).must_be_instance_of HTTParty::Response
      end
    end
    
    it "must successfully send messages to channels" do
      VCR.use_cassette("channel_chat_post_cassette") do
        expect(channel_recipient.send_message(channel_message)["message"]["text"]).must_equal channel_message
        
      end
    end
    
    it "must successfully send messages to individual recipients" do
      VCR.use_cassette("user_chat_post_cassette") do
        expect(user_recipient.send_message(user_message)["message"]["text"]).must_equal user_message
      end
    end
  end
end


