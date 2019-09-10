require_relative 'test_helper'

describe "user class" do
    describe "constructor intialize " do
        it "should return an instance of user" do
            slack_id = 4
            name = "Dom"
            real_name = "Dominic Tareto"
            
            slacker = User.new(slack_id, name, real_name)
            expect(slacker.slack_id).must_equal slack_id
            expect(slacker.name).must_equal name
            expect(slacker.real_name).must_equal real_name  
        end
    end
    
    describe "self.list method" do
        it "should return an array of users" do
            slack_id = 4
            name = "Dom"
            real_name = "Dominic Tareto"
            slacker = User.new(slack_id, name, real_name)
            
            expect(User.list).must_be_kind_of Array
            #expect(list).must_be_kind_of Array
        end
        
        it "should return instances of User" do
            #expect(@user).must_be_kind_of User
        end
    end
    
    
    
    
    
    
    
end