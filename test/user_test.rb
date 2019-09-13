require_relative 'test_helper'

describe "user instantiate" do 
  it "should instanitate as SlackCli::User" do
    @user1 = SlackCli::User.new(name:"Sara", real_name:"Monick", id: "6")
    expect(@user1).must_be_kind_of SlackCli::User
  end 
end 

describe "user list method should return correct values" do 
  it "all_users returns as an array with correct number of parameters" do 
    VCR.use_cassette("slack_details") do
      expect(SlackCli::User.list).must_be_kind_of Array
      expect(SlackCli::User.list.length).must_equal 3 
    end 
  end 

  it "user_hash contains name" do 
    VCR.use_cassette("slack_details") do
      expect(SlackCli::User.list[1][:user_name]).must_equal "monick.keo"
    end 
  end 

  it "user_hash contains real name" do 
    VCR.use_cassette("slack_details") do
      expect(SlackCli::User.list[1][:real_name]).must_equal "monick.keo"
    end 
  end 

  it "user_hash contains id" do 
    VCR.use_cassette("slack_details") do
      expect(SlackCli::User.list[1][:id]).must_equal "UN8JZT96J"
    end 
  end 
end 