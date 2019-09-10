require_relative 'test_helper'
require 'simplecov'
require 'pry'
SimpleCov.start

describe "User class" do 
  describe "User instansiation" do 
    binding.pry
    
    
    it "returns hash type data structure"
    expect(@user_name.user_list[0]).must_be_instance_of User
  end 
  
  it "returns a hash" do
    expect(@location_hash).must_be_instance_of Hash
  end
end