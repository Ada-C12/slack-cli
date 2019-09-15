require_relative 'test_helper'

describe "instances of user initiate " do 
  
  before do  
    @test_name = "Awesome"
    @test_id = "luckynumber13"
    @test_real_name = "Hella Awesome"
    @test_status_text = "Bein Awesome"
    @test_emoji = ":sunglasses:"
  end
  
  it "verifies that attempting to initialize an instance of User without appropriate data throws an ArgumentError" do
    integer_test_name = 00132
    expect { @test_user = User.new(name: integer_test_name, slack_id: @test_id, real_name: @test_real_name, status_text: @test_status_text, status_emoji: @test_emoji) }.must_raise ArgumentError 
    
    integer_slack_id = 13
    expect{
      @test_user = User.new(name: @test_name, slack_id: integer_slack_id, real_name: @test_real_name, status_text: @test_status_text, status_emoji: @test_emoji)
    }.must_raise ArgumentError 
    
    array_real_name = ["awesome", "pawsome"]  
    expect{
      @test_user = User.new(name: @test_name, slack_id: @test_id, real_name: array_real_name, status_text: @test_status_text, status_emoji: @test_emoji)
    }.must_raise ArgumentError 
    
    integer_status_text = 99443  
    expect{
      @test_user = User.new(name: @test_name, slack_id: @test_id, real_name: @test_real_name, status_text: integer_status_text, status_emoji: @test_emoji)
    }.must_raise ArgumentError 
    
    stringy_emoji = "sunglasses"
    expect{
      @test_user = User.new(name: @test_name, slack_id: @test_id, real_name: @test_real_name, status_text: @test_status_text, status_emoji: stringy_emoji)
    }.must_raise ArgumentError     
    
    stringy_emoji = 32978234
    expect{
      @test_user = User.new(name: @test_name, slack_id: @test_id, real_name: @test_real_name, status_text: @test_status_text, status_emoji: stringy_emoji)
    }.must_raise ArgumentError  
  end
end

describe "instances of user initiate " do 
  before do
    @test_name = "Awesome"
    @test_id = "luckynumber13"
    @test_real_name = "Hella Awesome"
    @test_status_text = "Bein Awesome"
    @test_emoji = ":sunglasses:"
  end
  
  it "verify initialization of User with accurate information" do
    
    @test_user = User.new(name: @test_name, slack_id: @test_id, real_name: @test_real_name, status_text: @test_status_text, status_emoji: @test_emoji)
    
    expect(@test_user).must_be_kind_of User
    expect(@test_user.name).must_equal @test_name
    expect(@test_user.slack_id).must_equal @test_id
    expect(@test_user.real_name).must_equal @test_real_name 
    expect(@test_user.status_text).must_equal @test_status_text
    expect(@test_user.status_emoji).must_equal @test_emoji
    
  end
  
end

describe "fleshed-out methods of being able to provide a detailed summary" do
  
  before do
    @test_name = "Awesome"
    @test_id = "luckynumber13"
    @test_real_name = "Hella Awesome"
    @test_status_text = "Bein Awesome"
    @test_emoji = ":sunglasses:"
    
    @test_user = User.new(name: @test_name, slack_id: @test_id, real_name: @test_real_name, status_text: @test_status_text, status_emoji: @test_emoji)
  end
  it "verifies the type of return provided by details" do
    
    detail_statement = @test_user.details
    
    expect(detail_statement).must_be_kind_of String 
    expect(detail_statement).must_include(@test_name)
    expect(detail_statement).must_include(@test_id)
    expect(detail_statement).must_include(@test_real_name)
    expect(detail_statement).must_include(@test_status_text)
    expect(detail_statement).must_include(@test_emoji)
  end
  
end





