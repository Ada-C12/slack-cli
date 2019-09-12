require_relative "test_helper"
describe "Workspace" do
  before do
    VCR.use_cassette("construct_workspace") do
      @workspace = Workspace.new
    end
  end
  
  describe "#initialize" do
    it "creates instance of Workspace" do
      expect(@workspace).must_be_kind_of Workspace
    end
    
    it "responds to variable names" do
      [:users, :channels, :selected].each do |variable|
        expect(@workspace).must_respond_to variable
      end
    end
    
    it "creates accurate attributes" do
      expect(@workspace.users).must_be_kind_of Array
      @workspace.users.each do |user|
        expect(user).must_be_instance_of User
      end
      
      expect(@workspace.channels).must_be_kind_of Array
      @workspace.channels.each do |channel|
        expect(channel).must_be_instance_of Channel
      end
      
      expect(@workspace.selected).must_be_nil
    end
  end
  
  describe "#select_channel" do
    it "returns instance of Channel when name is provided" do
      expect(@workspace.select_channel(input: "random")).must_be_instance_of Channel
    end

    it "returns instance of Channel when id is provided" do
      expect(@workspace.select_channel(input: "CN5RT17J8")).must_be_instance_of Channel
    end

    it "raises exception if no name or id provided" do
      expect{ @workspace.select_channel }.must_raise ArgumentError
    end
  end
  
  describe "#select_user" do
    it "returns instance of User when name is provided" do
      expect(@workspace.select_user(input: "slackbot")).must_be_instance_of User
    end

    it "returns instance of User when id is provided" do
      expect(@workspace.select_user(input: "USLACKBOT")).must_be_instance_of User
    end

    it "raises exception if no name or id provided" do
      expect{ @workspace.select_user }.must_raise ArgumentError
    end
  end

  describe "#show_details" do
    it "returns details if @selected is user" do
      @workspace.select_user(input: "slackbot")

      expect(@workspace.show_details).wont_be_nil
      expect(@workspace.show_details).must_include "slackbot"
      expect(@workspace.show_details).must_include "Slackbot"
      expect(@workspace.show_details).must_include "USLACKBOT"
    end

    it "returns details if @selected is channel" do
      expect(@workspace.select_channel(input: "random"))

      expect(@workspace.show_details).wont_be_nil
      expect(@workspace.show_details).must_include "random"
      expect(@workspace.show_details).must_include "CN5RT17J8"
      expect(@workspace.show_details).must_include "2"
      expect(@workspace.show_details).must_include "Non-work banter and water cooler conversation"
    end

    it "returns nil if nothing is @selected" do
      expect(@workspace.show_details).must_be_nil
    end
  end
  
  xdescribe "#send_message" do
    it "can send a valid message" do
      response = @workspace.send_message("This is a message", "general")
      
      expect(response).wont_be_nil
      expect(response).must_equal true
    end
  end
end
