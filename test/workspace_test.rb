require_relative 'test_helper'

describe "workplace attributes" do
 before do
  @test_workspace = Workspace.new
 end
 
 it "recognizes that it's an instance of Workspace" do
  expect(@test_workspace).must_be_kind_of Workspace
  expect(@test_workspace.users).must_be_kind_of Array
  expect(@test_workspace.channels).must_be_kind_of Array
 end
end

describe "workplace behavior in talking to Slack API" do
 
  before do
    @test_workspace = Workspace.new
   end
  end
 
 it "will call Slack API succesfully" do
  VCR.use_cassette("cassettes") do
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
