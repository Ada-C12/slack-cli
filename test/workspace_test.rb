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

describe 'it can list users by returning an array of hashes to be table_printed' do
  let (:workspace) {
    VCR.use_cassette("workspace.new") do
      SlackCLI::Workspace.new
    end
  }
  it 'returns an array of hashes' do
  expect(workspace.list_users).must_be_kind_of Array
  end
  it 'contains five key-value pairs in each hash' do
  expect(workspace.list_users[0].length).must_equal 5
  end
  it 'has slack_id as a key' do
  expect(workspace.list_users.last).must_include "slack_id"
  end
end

describe 'it can list channels by returning an array of hashes to be table_printed' do
  let (:workspace) {
    VCR.use_cassette("workspace.new") do
      SlackCLI::Workspace.new
    end
  }
  it 'returns an array of hashes' do
  expect(workspace.list_channels).must_be_kind_of Array
  end
  it 'contains four key-value pairs in each hash' do
  expect(workspace.list_channels[0].length).must_equal 4
  end
  it 'has slack_id as a key' do
  expect(workspace.list_users.last).must_include "slack_id"
  end
end

describe 'select user' do
it 'allows user to select user'
end
it ' '
end

describe 'prints details about selected user or channel' do
  let (:workspace) {
    VCR.use_cassette("workspace.new") do
      SlackCLI::Workspace.new
    end
  }
it 'determines if the object selected is a user or a channel'
workspace.
expect
end
