require_relative "test_helper"

describe "User" do 
  before do
    @user = User.new(real_name: "Bob", slack_id: "1234", name: "Bobiscool")
  end
  describe "initialize" do
    it "creates instance of User" do
      VCR.use_cassette("initialize_user") do
        expect(@user).must_be_kind_of User
      end
    end
    
    it "responds to variable names" do
      VCR.use_cassette("initialize_user") do
        [:real_name, :slack_id, :name].each do |variable|
          expect(@user).must_respond_to variable
        end
      end
    end
    
    it "creates accurate attributes" do
      VCR.use_cassette("initialize_user") do
        expect(@user.real_name).must_be_kind_of String
        expect(@user.real_name).must_equal "Bob"
        
        expect(@user.name).must_be_kind_of String
        expect(@user.name).must_equal "Bobiscool"
        
        expect(@user.slack_id).must_be_kind_of String
        expect(@user.slack_id).must_equal "1234"
      end
    end
  end
  
  describe "#details" do
    it "must return something" do
      expect (@user.details).wont_be_nil
    end

    it "must return accurate info" do
      expect (@user.details).must_include "Bob"
      expect (@user.details).must_include "1234"
      expect (@user.details).must_include "Bobiscool"
    end
  end
  
  describe "list method" do 
    it "self.list returns an array of users" do 
      VCR.use_cassette("list_users") do 
        results = User.list 
        expect(results).must_be_instance_of Array 
        results.each do |result|
          expect(result).must_be_instance_of User
          
        end 
      end 
    end 
    
    it "returns accurate information" do
      VCR.use_cassette("list_users") do 
        results = User.list
        
        info = [
          {slack_id: "USLACKBOT", name: "slackbot", real_name: "Slackbot"},
          {slack_id: "UMURTAYP5", name:"juliabouv", real_name:"Julia Bouvier"},
          {slack_id:"UN863PN23", name:"amalh.a97", real_name:"Amal"}
        ]
        
        results.each_with_index do |result, index|
          expect(result.slack_id).must_be_kind_of String
          expect(result.slack_id).must_equal info[index][:slack_id]
          
          expect(result.name).must_be_kind_of String
          expect(result.name).must_equal info[index][:name]
          
          expect(result.real_name).must_be_kind_of String
          expect(result.real_name).must_equal info[index][:real_name]
        end
      end
    end
  end 
end
