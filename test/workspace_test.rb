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
