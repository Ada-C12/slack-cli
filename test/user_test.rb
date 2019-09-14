require_relative 'test_helper'

describe 'class user' do
  let(:user){Slack::User.new(id: "USLACKBOT", name: "slackbot", real_name: "Slackbot", status_text: "Print is dead", status_emoji: ":books:")}
  
  describe 'initialize' do 
    
    it 'creates a new instance of User' do
      expect(user).must_be_instance_of Slack::User
    end
    
    it 'accurately stores attributes' do
      expect(user.id).must_be_instance_of String
      expect(user.id).must_equal "USLACKBOT"
      
      expect(user.name).must_be_instance_of String
      expect(user.name).must_equal "slackbot"
      
      expect(user.real_name).must_be_instance_of String
      expect(user.real_name).must_equal "Slackbot"
      
      expect(user.status_text).must_be_instance_of String
      expect(user.status_text).must_equal "Print is dead"
      
      expect(user.status_emoji).must_be_instance_of String
      expect(user.status_emoji).must_equal ":books:"
      
    end
  end
  
  describe 'self.list' do 
    it "returns an array of user objects" do 
      VCR.use_cassette("user_list_cassette") do
        list = Slack::User.list
        expect(list).must_be_instance_of Array 
        list.each do |user|
          expect(user).must_be_instance_of Slack::User 
        end
      end
    end
  end
  
  describe 'details' do
    let(:result){user.details}
    
    it 'returns a hash' do
      expect(result).must_be_instance_of Hash
    end
    
    it 'returns a hash with length 5' do
      expect(result.length).must_equal 5
    end
    
    it "accurately stores the current user's information" do
      expect(result[:username]).must_equal 'slackbot'
      expect(result[:id]).must_equal 'USLACKBOT'
      expect(result[:real_name]).must_equal 'Slackbot'
      expect(result[:status_text]).must_equal 'Print is dead'
      expect(result[:status_emoji]).must_equal ':books:'
    end
    
  end
  
end
