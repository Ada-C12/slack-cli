require_relative 'test_helper'
require_relative '../lib/workspace'
require 'pry'

describe "Workspace" do
  it "instantiates Workspace" do
    VCR.use_cassette("workspace_test") do
      expect(Workspace.new).must_be_instance_of Workspace
    end
  end
  
  describe "select_user method" do
    it "returns an instance of user" do
      VCR.use_cassette("workspace_select_user") do
        selection = Workspace.new.select_user("erika.maust") 
        expect(selection.user_name).must_equal "erika.maust"
        expect(selection.real_name).must_equal "Erika"
      end
    end
  end
  
  describe "select_channel method" do
    it "returns an instance of channel" do
      VCR.use_cassette("workspace_select_channel") do
        selection = Workspace.new.select_channel("random") 
        expect(selection.name).must_equal "random"
        expect(selection.member_count).must_equal 2
      end
    end
  end
  
  # describe "show_details method" do
  #   it "" do
  #     VCR.use_cassette("workspace_show_details") do
  #       workspace = Workspace.new
  #       selected_channel = "general"
  #       selected_user = "slackbot"

  #       workspace.select_channel(selected_channel)
  #       channel_detail = @new_workspace.show_details
  #       @new_workspace.select_user(selected_user)
  #       user_detail = @new_workspace.show_details

  #       expect(channel_detail).must_include "CN69K7ERE"
  #       expect(details_2).must_include "USLACKBOT"
        
  #     end
  #   end
  # end 
end
