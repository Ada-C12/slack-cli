require_relative 'test_helper'

describe "User" do
  describe "initialize" do
    it "can be initialized as child class of Recipient" do
      slack_id = "TD83838H"
      name = "SlackBot"
      real_name = "Mr. Slack Bot"

      new_recipient = SlackCLI::User.new(slack_id: slack_id, name: name, real_name: real_name)

      expect(new_recipient.superclass).must_equal SlackCLI::Recipient
    end



  end

end
