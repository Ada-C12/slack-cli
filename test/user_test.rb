require_relative 'test_helper'

describe "User" do
  describe "initialize" do
    it "can be initialized as child class of Recipient" do
      slack_id = "TD83838H"
      name = "SlackBot"
      real_name = "SlackBot"

      new_recipient = SlackCLI::User.new(
        slack_id: slack_id, 
        name: name, 
        real_name: real_name
      )

      expect(new_recipient.class < SlackCLI::Recipient).must_equal true
    end
  end

  describe "self.list" do
    it "creates a list of at least 1 user" do
      VCR.use_cassette("list_users") do
        users_list = SlackCLI::User.list

        expect(users_list).must_be_instance_of Array
        expect(users_list.first).must_be_instance_of SlackCLI::User
      end
    end

  end

end
