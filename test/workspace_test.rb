require_relative 'test_helper'
require_relative '../lib/workspace'
require 'pry'

describe "Workspace" do
  it "creates an instance of Workspace" do
    VCR.use_cassette("Workspace initialized") do
      expect(Workspace.new).must_be_instance_of Workspace
    end
  end
  
  it "returns an instance of User" do
    VCR.use_cassette("return User") do
      selection = Workspace.new.select_user("erika.maust") 
      expect(selection).must_be_instance_of User
    end
  end
  
  it "returns correct information for selected user" do
    VCR.use_cassette("WSP_user_info") do
      selection = Workspace.new.select_user("erika.maust") 
      expect(selection.user_name).must_equal "erika.maust"
      expect(selection.real_name).must_equal "Erika"
    end
  end
  
  it "returns an instance of Channel" do
    VCR.use_cassette("return Channel") do
      selection = Workspace.new.select_channel("random") 
      expect(selection).must_be_instance_of Channel
    end
  end
  
  it "returns correct information for selected channel" do
    VCR.use_cassette("WSP_select_channel") do
      selection = Workspace.new.select_channel("random")
      expect(selection.name).must_equal "random"
      expect(selection.member_count).must_equal 2
    end
  end
  
  it "returns correct ID when user id is selected" do
    VCR.use_cassette("workspace_show_details_user") do
      workspace = Workspace.new
      selection = "slackbot"
      workspace.select_user(selection)
      selection_detail = workspace.show_details
      expect(selection_detail.slack_id).must_equal "USLACKBOT"
    end
  end
  
  it "shows details for channel" do
    VCR.use_cassette("workspace_show_details_channel") do
      workspace = Workspace.new
      selection = "general"
      workspace.select_channel(selection)
      selection_detail = workspace.show_details
      expect(selection_detail.slack_id).must_equal "CN69K7ERE"
    end
  end
  
  it "successfully sends a message" do
    VCR.use_cassette("workspace_show_details_channel") do
      response = Workspace.new.send_message("Message for you, sir", "general")
      expect(response).wont_be_nil
      expect(response["ok"]).must_equal true
    end
  end
end
