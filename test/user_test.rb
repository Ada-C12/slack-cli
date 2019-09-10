require_relative 'test_helper'

describe "User" do
  describe "initialize" do
    it "establishes the base attributes when instantiated" do
      user = Slack::User.new(name: "spengler", real_name: "Bob Spengler", slack_id: "W012A3CDE")
      [:name, :real_name, :slack_id].each do |attribute|
        expect(user).must_respond_to attribute
      end
      # expect(user.name).must_respond
      # expect(user.real_name)
      # expect(user.slack_id)
    end

  end


















end