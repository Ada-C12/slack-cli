require_relative "test_helper"

describe "User methods" do
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

  it "raises an error if a valid user is not found" do
    expect do
      @selected = @workspace.select_user("asjdakwjrer")
    end.must_raise SlackApiError
  end
end

describe "Channel methods" do
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

  it "raises an error if a valid channel is not found" do
    expect do
      @selected = @workspace.select_channel("cute dogs")
    end.must_raise SlackApiError
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
    @workspace.select_channel("fuzzy_bunnies")
    expect(@workspace.show_details).must_be_kind_of String
  end

  it "returns the selected user's details" do
    @workspace.select_user("idhallie")
    expect(@workspace.show_details).must_be_kind_of String
  end
end

describe "send_message method" do
  it "sends a message to the chosen channel" do
    VCR.use_cassette("channels_list") do
      @channel_array = Slack::Channel.list
      @workspace = Slack::Workspace.new
      body = {
        token: ENV["SLACK_TOKEN"],
        channel: "fuzzy_bunnies",
        text: "hello from the other side",
      }

      @response = HTTParty.post(MESSAGE_URL, body: body)
    end

    expect(@response).must_be_kind_of HTTParty::Response
  end

  it "sends a message to the chosen user" do
    VCR.use_cassette("users_list") do
      @user_array = Slack::User.list
      @workspace = Slack::Workspace.new
      body = {
        token: ENV["SLACK_TOKEN"],
        channel: "UN69TR3N1",
        text: "hello from the other side",
      }

      @response = HTTParty.post(MESSAGE_URL, body: body)
    end

    expect(@response).must_be_kind_of HTTParty::Response
  end

  it "returns true if the selected channel is valid and sends a message" do
    VCR.use_cassette("message_post") do
      @workspace = Slack::Workspace.new
      @selected = @workspace.select_channel("apis")
      @response = @workspace.send_message("Helllooo")
    end

    expect(@response["ok"]).must_equal true
  end

  it "returns true if the selected user is valid and sends a message" do
    VCR.use_cassette("message_post") do
      @workspace = Slack::Workspace.new
      @selected = @workspace.select_user("nickyjinchoi")
      @response = @workspace.send_message("Helllooo. What's uppp?")
    end

    expect(@response["ok"]).must_equal true
  end

  it "returns nil if a recipient has not been selected" do
    VCR.use_cassette("message_post") do
      @workspace = Slack::Workspace.new
      @selected = nil
      @response = @workspace.send_message("This will go nowhere")
    end

    expect(@response).must_be_nil
  end
end
