require_relative 'test_helper'

describe "Recipient" do
  describe "initialize" do
    it "can be initialized with an ID and a name" do
      slack_id = "TD83838H"
      name = "SlackBot"

      new_recipient = SlackCLI::Recipient.new(slack_id: slack_id, name: name)

      expect(new_recipient).must_be_instance_of SlackCLI::Recipient
    end
  end

  describe "self.get" do
    it "raises an error if the API returns an error response" do
      # "recipient_gets" cassette was created with invalid token
      VCR.use_cassette("recipient_gets_error") do
        assert_raises(SlackCLI::SlackApiError) {
          SlackCLI::Recipient.get("https://slack.com/api/users.list")
        }
      end
    end
  end

  describe "send_message" do
    it "sends a message and returns true if it was successful" do
      VCR.use_cassette("recipient_send_message") do
        workspace = SlackCLI::Workspace.new
        channel_random = workspace.find_instance(workspace.channels, "random")
        # slack_id = "CN9NG0YUE"  # "random" channel
        response = channel_random.send_message("trying to send from recipient_test")
        expect(response).must_equal true

        user_slackbot = workspace.find_instance(workspace.users, "slackbot")
        response_2 = user_slackbot.send_message("trying to send from recipient_test to slackbot")
        expect(response_2).must_equal true
      end
    end
    it "raises an error if message isn't sent" do
      VCR.use_cassette("recipient_send_message") do
        assert_raises(SlackCLI::SlackApiError) {
          fake_user = SlackCLI::User.new(
            slack_id: 55555,
            name: "fake name",
            real_name: "fake real name"
          )
          fake_user.send_message("trying to send from recipient_test to nonexistent User")
        }
      end
    end
  end

end
