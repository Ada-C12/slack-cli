require_relative 'test_helper'

describe "instances of user initiate " do 
  #throws all sorts of errors for missing or mis-classed information
end


describe "instances of user initiate properly using manually passed in data" do
  
  before do
    @test_name = "Awesome"
    @test_id = "luckynumber13"
    @test_real_name = "Hella Awesome"
    @test_status_text = "Bein Awesome"
    @test_emoji = ":sunglasses:"
    
    @test_user = User.new(name: @test_name, slack_id: @test_id, real_name: @test_real_name, status_test: @test_status_text, status_emoji: @test_emoji)
  end
  
  it "verify initialization of User" do
    
    expect(@test_user).is_kind_of User
    expect(@test_user.name).must_equal @test_name
    expect(@test_user.slack_id).must_equal @test_id
    expect(@test_user.real_name).must_equal @test_real_name 
    expect(@test_user.status_text).must_equal @test_status_text
    expect(@test_user.status_emoji).must_equal @test_emoji
    
  end
  
  
  describe "fleshed-out methods of being able to provide a detailed summary" do
  end
  
  describe "fleshed-out methods of being able to make a list of instances of itself" do
  end
  
  describe "instances of user can initiate from API and parse the data" do
    
    
    #Any tests involving a User should use the username SlackBot
    
    before do
    end
    
    it "is a test, maybe?"
    
  end
  
  # describe ""
  
  describe "user attributes and behaviors" do
    
    before do
    end
    
    it "is a test, maybe?"
    VCR.use_cassette("slack_info") do
    end
  end
  
  describe "user attributes and behaviors" do
    
    before do
    end
    
    it "is a test, maybe?"
    VCR.use_cassette("slack_info") do
    end
  end
end 