require_relative "test_helper"

describe "Recipient class - NotImplementedError for Template methods" do
  it "returns NotImplementedError for details method" do
    @recipient = Slack::Recipient.new(name: "BotBot", slack_id: "UWSJKE")
    expect do
      @recipient.details
    end.must_raise NotImplementedError
  end

  it "returns NotImplementedError for Recipient.list method" do
    expect do
      Slack::Recipient.list
    end.must_raise NotImplementedError
  end
end

describe "Recipient send_message method" do
  it "returns false if the selected channel is not valid" do
    expect do
      VCR.use_cassette("message_post") do
        @recipient = Slack::Recipient.new(name: "harold", slack_id: "UN69ewrkjwer")
        @response = @recipient.send_message("Adorable doggos")
        @response["ok"]
      end.must_raise SlackApiError, ("Invalid request. Error is 200: OK")
    end
  end
end
