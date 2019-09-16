require_relative 'test_helper'
require_relative '../lib/user'
require_relative '../lib/recipient'
require 'pry'
require 'httparty'
require  'dotenv'

Dotenv.load



describe "User class" do
  
  it "initializes User" do
    expect(User.new(slack_id: 234, user_name: "thewho", real_name:"The What", detail: "Well, well, well")).must_be_instance_of User
  end
  
  it "assigns correct value to instance variables" do
    users = User.new(slack_id: 234, user_name: "thewho", real_name:"The What", detail: "Well, well, well")
    
    expect(users.slack_id).must_equal 234
    expect(users.user_name).must_equal "thewho"
    expect(users.real_name).must_equal "The What"
  end
  
  it "creates an array of instances of users" do
    VCR.use_cassette("user") do
      expect(User.list).must_be_kind_of Array
      expect(User.list).wont_be_empty
    end
  end
  
end