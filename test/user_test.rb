require_relative 'test_helper'
require 'awesome_print'

describe "User" do
  describe "initialize" do
    it "establishes the base attributes when instantiated" do
      user = Slack::User.new(username: "spengler", real_name: "Bob Spengler", slack_id: "W012A3CDE")
      [:username, :real_name, :slack_id].each do |attribute|
        expect(user).must_respond_to attribute
      end
    end
  end
end