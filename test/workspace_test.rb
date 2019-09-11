require_relative 'test_helper'

describe 'can create a workspace' do
  let (:workspace) {
    SlackCLI::Workspace.new
  }
  
  it 'creates a workspace' do
    expect(workspace).must_be_instance_of SlackCLI::Workspace 
    expect(workspace.selected).must_be nil 
  end
  
  it 'has an array of channels' do
    expect(workspace.channels).must_be_kind_of Array
    expect(workspace.channels[0]).must_be_instance_of Channel
  end 
  
  it 'has an array of users' do
    expect(workspace.users).must_be_kind_of Array
    expect(workspace.users[0]).must_be_instance_of User
  end 
end


