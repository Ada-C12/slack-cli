require_relative 'test_helper'

describe 'class recipient' do
  describe 'initialize' do 
    let(:recipient){
    Slack::Recipient.new(id: "C0G9QF9GW", name: "Hey")}
    
    it 'creates a new instance of Recipient' do
      expect(recipient).must_be_instance_of Slack::Recipient
    end
    
    it 'accurately stores slack_id' do
      expect(recipient.id).must_be_instance_of String
      expect(recipient.id).must_equal "C0G9QF9GW"
    end
    
    it 'accurately stores name' do
      expect(recipient.name).must_be_instance_of String
      expect(recipient.name).must_equal "Hey"
    end
  end
  
  describe 'self.get' do
    
    
    it 'should return an instance of HTTParty::Response' do
      VCR.use_cassette("recipient_get_method") do
        url = "https://slack.com/api/users.list"
        params = {token: ENV["SLACK_TOKEN"]}
        
        response = Slack::Recipient.get(url, params)
        
        expect(response).must_be_instance_of HTTParty::Response
      end
      
    end
    
    it 'should raise a Slack_Api_Error if the response code is not 200' do
      VCR.use_cassette("get_recipient_error") do
        puts 
        expect{Slack::Recipient.get("https://us1.locationiq.org/v1/search.php?", {token: ENV["SLACK_TOKEN"]})}.must_raise Slack::Slack_Api_Error
        
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
  
end