require_relative 'test_helper'

describe 'can create a workspace' do
  
  let (:workspace) { 
    VCR.use_cassette("workspace.new") do
      SlackCLI::Workspace.new
    end 
  }
  
  it 'creates a workspace' do
    expect(workspace).must_be_instance_of SlackCLI::Workspace 
    expect(workspace.selected).must_be_nil 
  end
  
  it 'has an array of channels' do
    expect(workspace.channels).must_be_kind_of Array
    expect(workspace.channels[0]).must_be_instance_of SlackCLI::Channel
  end 
  
  it 'has an array of users' do
    expect(workspace.users).must_be_kind_of Array
    expect(workspace.users[0]).must_be_instance_of SlackCLI::User
  end 
end


