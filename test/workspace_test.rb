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
  let (:workspace) {
    VCR.use_cassette("workspace.new") do
      SlackCLI::Workspace.new
    end
  }
  it 'allows user to select user' do
    expect(workspace.select_user("Slackbot")).must_be_instance_of SlackCLI::User
  end
  it "returns nil when not a known user" do
    expect(workspace.select_user("Mr. T")).must_be_nil
  end
  it 'allows user to select channel' do
    expect(workspace.select_channel("random")).must_be_instance_of SlackCLI::Channel
  end
  it "returns nil when not a known channel" do
    expect(workspace.select_channel("MTV")).must_be_nil
  end
end

describe 'prints details about selected user or channel' do
  let (:workspace) {
    VCR.use_cassette("workspace.new") do
      SlackCLI::Workspace.new
    end
  }
  it 'determines if the object selected is a user or a channel' do
    selected = workspace.select_channel('random')
    expect(workspace.print_details(selected)).must_be_kind_of Array
    selected = workspace.select_channel('random')
    expect(workspace.print_details(selected)[0].length).must_equal 4
    selected = workspace.select_user('Slackbot')
    expect(workspace.print_details(selected)).must_be_kind_of Array
    selected = workspace.select_user('Slackbot')
    expect(workspace.print_details(selected)[0].length).must_equal 5
  end
  it 'returns nil no user or channel is selected' do
    expect(workspace.print_details(@selected)).must_be_nil
  end
end