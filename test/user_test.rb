require_relative 'test_helper'
require 'pry'

describe "User class" do

  it "can create an instance" do
    VCR.use_cassette("user_list_generation") do
      
      id = "USLACKBOT"
      name = "slackbot"
      real_name = "Slackbot"
      user = User.new(id, name, real_name)
      
      expect(user).must_be_instance_of User
      expect(user.id).must_equal "USLACKBOT"
    end
  end
end