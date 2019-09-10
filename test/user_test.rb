require_relative 'test_helper'
require 'pry'

describe "User class" do
  it "can get user list" do
    VCR.use_cassette("user_list_generation") do
      id = 
      username = "SlackBot"
      response = User.new(id, username, real_name)

      expect(response["SlackBot"]).wont_be_nil
      expect(response["Seattle"][:lon]).must_equal "-122.3300624"
      expect(response["Seattle"][:lat]).must_equal "47.6038321"
    end
  end