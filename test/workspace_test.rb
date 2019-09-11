require_relative "test_helper"

describe "User.list method" do
  before do
    VCR.use_cassette("users_list") do
      @user_array = Slack::User.list
      @workspace = Slack::Workspace.new
    end
  end

  it "users is list of type User" do
    expect(@workspace.users.all? { |user| user.is_a?(Slack::User) }).must_equal true
  end

  it "will select a user by name" do
    @workspace.select_user("slackbot")
    expect(@workspace.selected.is_a?(Slack::User)).must_equal true
  end

  it "will select a user by slack_id" do
    @workspace.select_user("USLACKBOT")
    expect(@workspace.selected.is_a?(Slack::User)).must_equal true
  end
end

describe "Channel.list method" do
  before do
    VCR.use_cassette("channels_list") do
      @channel_array = Slack::Channel.list
      @workspace = Slack::Workspace.new
    end
  end

  it "channels is a list of type Channel" do
    expect(@workspace.channels.all? { |channel| channel.is_a?(Slack::Channel) }).must_equal true
  end

  it "will select a channel by name" do
    @workspace.select_channel("fuzzy_bunnies")
    expect(@workspace.selected.is_a?(Slack::Channel)).must_equal true
  end

  it "will select a channel by slack_id" do
    @workspace.select_channel("CN759T0MA")
    expect(@workspace.selected.is_a?(Slack::Channel)).must_equal true
  end
end

describe "show_details method" do
  before do
    VCR.use_cassette("channels_list") do
      @channel_array = Slack::Channel.list
      @workspace = Slack::Workspace.new
    end
  end

  it "returns the selected channel's details" do
    # p @workspace.select_channel("fuzzy_bunnies").inspect
    @workspace.select_channel("fuzzy_bunnies")
    expect(@workspace.show_details).must_be_kind_of String
  end

  it "returns the selected user's details" do
    @workspace.select_user("idhallie")
    expect(@workspace.show_details).must_be_kind_of String
  end
end
