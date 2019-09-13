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

  describe "details" do
    before do
      VCR.use_cassette("list_users") do
        @users_list = SlackCLI::User.list
      end
    end

    it "returns a string" do
      user_details = @users_list[0].details

      expect(user_details).must_be_instance_of String
    end

    it "returns accurate details about the user" do
      user_details2 = @users_list[0].details

      expect(user_details2).must_include "USLACKBOT"
      expect(user_details2).must_include "slackbot"
      expect(user_details2).must_include "Slackbot"
    end
  end
end
