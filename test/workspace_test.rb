require_relative 'test_helper'

describe 'workplace class' do
  before do
    @test_workspace = Workspace.new
  end

  describe "workplace attributes" do
    it "recognizes that it's an instance of Workspace" do
      VCR.use_cassette("initialize") do
      expect(@test_workspace).must_be_kind_of Workspace
      expect(@test_workspace.users).must_be_kind_of Array
      expect(@test_workspace.channels).must_be_kind_of Array
      end 
    end
  end 

  describe "workplace behavior in talking to Slack API" do
    it "will call Slack API succesfully" do
      VCR.use_cassette("api_call_list_users") do
      expect(@test_workspace.api_call_list_users).must_equal true
      end
    end
  end 

  describe "make_users" do 
    #This checks our make_users method because users is an array of user objects populated by the make_users method
    it "parses user API accurately into new User objects" do 
      users = test_workspace.users[0]
      expect(users).must_be_kind_of User 
    #expecting to have to parse the data from Slack API into something that's recognizable wherein "name" has a predictable value (will be checked against information in Postman)
    end
  end
end 

#  describe "list "
#  # upon request, will use Slack API data to interact with / as a user or channel 
#   end
