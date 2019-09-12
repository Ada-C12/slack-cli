require_relative 'test_helper'

describe "instances of channel initiate " do 
  #throws all sorts of errors for missing or mis-classed information
  before do
    @test_name = "Awesome"
    @test_slack_id = "luckynumber13"
    @test_topic = "Awesome existence"
    @test_member_count = 9
  end
  
  it "verifies that attempting to initialize an instance of Channel without appropriate data throws an ArgumentError" do
    integer_name = 00132
    test_channel = Channel.new(name: integer_name, slack_id: @test_slack_id, topic: @test_topic, member_count: @test_member_count)
    
    expect{ test_channel }.must_raise ArgumentError 
    
    # integer_slack_id = 13
    # expect{
    #   @test_channel = Channel.new(name: @test_name, slack_id: integer_slack_id, topic: @test_topic, member_count: @test_member_count)
    # }.must_raise ArgumentError 
    
    # array_topic = ["awesome", "pawsome"]  
    # expect{
    #   @test_channel = Channel.new(name: @test_name, slack_id: @test_slack_id, topic: array_topic , member_count: @test_member_count)
    # }.must_raise ArgumentError 
    
    # integer_member_count = 99443  
    # expect{
    #   @test_channel = Channel.new(name: @test_name, slack_id: @test_slack_id, topic: @test_topic, member_count: integer_member_count)
    # }.must_raise ArgumentError    
  end
end

describe "instances of channel initiate properly using manually passed in data" do
  
  before do
    @test_name = "Awesome"
    @test_slack_id = "3456713"
    @test_topic = "Awesome existence"
    @test_member_count = 9
    
    @test_channel = Channel.new(name: @test_name, slack_id: @test_slack_id, topic: @test_topic, member_count: @test_member_count)
  end
  
  it "verify initialization of Channel" do
    
    expect(@test_channel).must_be_kind_of Channel
    expect(@test_channel.name).must_equal @test_name
    expect(@test_channel.slack_id).must_equal @test_slack_id
    expect(@test_channel.topic).must_equal @test_topic
    expect(@test_channel.member_count).must_equal @test_member_count
    
  end
end   
#     describe "fleshed-out methods of being able to provide a detailed summary" do
#     end

#     describe "fleshed-out methods of being able to make a list of instances of itself" do
#     end

#     describe "instances of user can initiate from API and parse the data" do


#       #Any tests involving a User should use the username SlackBot

#       before do
#       end

#       it "is a test, maybe?" do 

#     end

#     # describe ""

#     describe "user attributes and behaviors" do

#       before do
#       end

#       it "is a test, maybe?" do 
#         VCR.use_cassette("slack_info") do 
#         end
#       end 
#     end

#     describe "user attributes and behaviors" do

#       before do
#       end

#       it "is a test, maybe?" do 
#         VCR.use_cassette("slack_info") do
#       end
#     end
#   end 
# end 
