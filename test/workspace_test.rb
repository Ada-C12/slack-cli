require_relative 'test_helper'
require 'pry'

describe "Workspace" do
  it "instantiates Workspace" do
    VCR.use_cassette("workspace_test") do
      expect(Workspace.new).must_be_instance_of Workspace
    end
  end
end