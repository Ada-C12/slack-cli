require_relative 'test_helper'

describe 'workplace class' do

  describe "workplace attributes" do
    it "recognizes that it's an instance of Workspace" do
      VCR.use_cassette("initialize") do
        @test_workspace = Workspace.new
        
        expect(@test_workspace).must_be_kind_of Workspace
        expect(@test_workspace.users).must_be_kind_of Array
        expect(@test_workspace.channels).must_be_kind_of Array
      end 
    end
  end 
  
  describe "workplace behavior in talking to Slack API" do
    it "will call Slack API succesfully" do
      VCR.use_cassette("api_call_list_users") do
        @test_workspace = Workspace.new
        expect(@test_workspace.api_call_list_users).must_equal true
      end
    end
  end 
  
  #expecting to have to parse the data from Slack API into something that's recognizable wherein "name" has a predictable value (will be checked against information in Postman)
  describe "make_users" do 
    #This checks our make_users method because users is an array of user objects populated by the make_users method
    it "parses user API accurately into new User objects" do 
      VCR.use_cassette("make_users") do
        @test_workspace = Workspace.new 
        user = @test_workspace.users[0]
        expect(user).must_be_kind_of User 
      end
    end
  end 
  
  describe "make_channels" do 
    it "parases channel API accurately into new Channel objects" do 
      VCR.use_cassette("make_channels") do 
        @test_workspace = Workspace.new
        channel = @test_workspace.channels[0]
        expect(channel).must_be_kind_of Channel 
      end 
    end 
  end 
end 

describe "make summaries of users and channels for slack.rb to use" do
  before do 
    VCR.use_cassette("make_channels") do 
      @test_workspace = Workspace.new
    end
  end

  it "all_user_names compiles names of all users" do
    expected_number_of_users_postman = 3
    expected_first_user_postman = "slackbot"
    expect(@test_workspace.all_user_names).must_be_kind_of Array
    expect(@test_workspace.all_user_names.length).must_equal expected_number_of_users_postman
    expect(@test_workspace.all_user_names[0]).must_equal expected_first_user_postman
  end

  it "all_channel_names compiles names of all channels" do
    expected_number_of_channels_postman = 3
    expected_first_channel_postman = "random"
    expect(@test_workspace.all_channel_names).must_be_kind_of Array
    expect(@test_workspace.all_channel_names.length).must_equal expected_number_of_users_postman
    expect(@test_workspace.all_channel_names[0]).must_equal expected_first_user_postman
  end

end


#  describe "list "
#  # upon request, will use Slack API data to interact with / as a user or channel 
#   end
