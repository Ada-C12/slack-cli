require_relative 'test_helper'

describe "user class tests" do 
    before do 
      @recipient1 = SlackCli::Recipient.new(name:"Sara", id: "6")
    end 
  
    it "should instanitate as SlackCli::User" do
      expect(@recipient1).must_be_kind_of SlackCli::Recipient
    end 
end 
