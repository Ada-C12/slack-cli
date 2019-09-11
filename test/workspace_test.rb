require_relative 'test_helper'

describe "workplace attributes" do
 before do
  # VCR.use_cassette("cassettes") do
  @test_workspace = Workspace.new
 end
 # end
 
 it "recognizes that it's an instance of Workspace" do
  @test_workspace = Workspace.new
  expect(@test_workspace).must_be_kind_of Workspace
 end
 
 it "will hold an array of users which will be initially empty" do #temporary test
  @test_workspace = Workspace.new
  expect(@test_workspace.users).must_be_kind_of Array
  expect(@test_workspace.users).must_be_empty
 end
 
 it "will hold an array of channels which will be initially empty" do #temporary test
  @test_workspace = Workspace.new
  expect(@test_workspace.channels).must_be_kind_of Array
  expect(@test_workspace.channels).must_be_empty
 end
 
end

describe "workplace behavior in talking to Slack API" do
 
 #  before do
 #   VCR.use_cassette("cassettes") do
 #    @test_workspace = Workspace.new
 #   end
 #  end
 
 it "will call Slack API succesfully" do
  VCR.use_cassette("cassettes") do
   @test_workspace = Workspace.new
   expect(@test_workspace.api_call_list_users).must_equal true
  end
 end
 
 
 it "it will parse API data to retain necessary details about users" do 
  VCR.use_cassette("slack_info") do
   #expecting to have to parse the data from Slack API into something that's recognizable wherein "name" has a predictable value (will be checked against information in Postman)
  end
 end
 
 
 # upon request, will use Slack API data to interact with / as a user or channel 
end
