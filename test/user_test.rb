require_relative 'test_helper'

describe 'class user' do
  
  describe 'initialize' do 
    
    let(:user){
      Slack::User.new(id: "W012A3CDE", name: "spengler", real_name: "spengler", status_text: "Print is dead", status_emoji: ":books:")
    }
    
    it 'creates a new instance of User' do
      expect(user).must_be_instance_of Slack::User
    end
    
    it 'accurately stores attributes' do
      expect(user.id).must_be_instance_of String
      expect(user.id).must_equal "W012A3CDE"
      
      expect(user.name).must_be_instance_of String
      expect(user.name).must_equal "spengler"
      
      expect(user.real_name).must_be_instance_of String
      expect(user.real_name).must_equal "spengler"
      
      expect(user.status_text).must_be_instance_of String
      expect(user.status_text).must_equal "Print is dead"
      
      expect(user.status_emoji).must_be_instance_of String
      expect(user.status_emoji).must_equal ":books:"
      
    end
    
    
  end
  
  describe 'self.list' do 
    it "returns an array of user objects" do 
      VCR.use_cassette("list_users") do
        list = Slack::User.list
        expect(list).must_be_instance_of Array 
        
        list.each do |user|
          expect(user).must_be_instance_of Slack::User 
        end
        
        
      end
      
    end
    
    
  end
  
  
end
