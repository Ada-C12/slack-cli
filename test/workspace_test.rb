require_relative "test_helper"
require 'dotenv'
require 'httparty'

Dotenv.load

describe "Workspace" do
  before do
    VCR.use_cassette("workspace") do
      users = User.list
      channels = Channel.list
      selected = User.new("UN8GKRXK8", "Natalie Tapias", "natalie")
      @workspace = Workspace.new(users, channels, selected: selected)
    end
  end

  describe "Workspace instantiation" do
    it "is an instance of Workspace" do
      expect(@workspace).must_be_kind_of Workspace
    end

    it "gets the selected object from the select_user method" do
      VCR.use_cassette("workspace") do
        users = User.list
        channels = Channel.list
        workspace_1 = Workspace.new(users, channels)
        workspace_1.select_user("UMUS3K402")
        expect(workspace_1.selected).must_be_instance_of User
      end
    end 

  end

  describe "select_channel" do
    it "returns a selected channel instance" do
      VCR.use_cassette("workspace") do
        #Act
        selected_channel = @workspace.select_channel("random")

        #Assert
        expect(selected_channel).must_be_instance_of Channel
      end
    end

    it "raises an argument error for invalid selection" do
      VCR.use_cassette("workspace") do
        expect {(@workspace.select_channel("Pizza"))}.must_raise ArgumentError
      end
    end
  end  
  
  describe "select_user" do
    it "returns a selected user instance" do
      VCR.use_cassette("workspace") do
        #Act
        selected_user = @workspace.select_user("UMW5P9DHR")

        #Assert
        expect(selected_user).must_be_instance_of User
      end
    end

    it "raises an argument error for invalid selection" do
      VCR.use_cassette("workspace") do
        expect {(@workspace.select_user("Pizza"))}.must_raise ArgumentError
      end
    end

    it "assigns selected object to selected instance variable" do
      VCR.use_cassette("workspace") do
        # selection = "random"
        hello ="world"
        hi ="world"
        expect(hello).must_equal hi
        @workspace.select_channel("random")

        topic = {
        "value": "Non-work banter and water cooler conversation",
        "creator": "UMTGXDXD0",
        "last_set": 1568073948
        }
        result = Channel.new("CN5S0B30U", "random", topic, 4)

        expect(@workspace.selected).must_be_instance_of Channel
      end
    end 
  end    
end