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
end