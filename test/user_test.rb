require_relative "test_helper"
require 'dotenv'
require 'httparty'

Dotenv.load

describe "User" do
  before do
    slack_id = "1232452"
    name = "Dominique"
    real_name = "Dominique Taylor"
    @user = User.new(name, real_name, slack_id)
  end

  describe "User instantiation" do
    it "is an instance of User" do
      expect(@user).must_be_kind_of User
    end
  end

  describe "self.list" do
    it "returns a new user's list" do
      VCR.use_cassette("user") do
        #Act
        list = User.list
        #Assert
        expect(list).must_be_kind_of Array
        expect(list.length).must_equal 5
      end
    end

    it "Returns accurate information about the first user" do
      VCR.use_cassette("user") do
        first = User.list.first
        expect(first.slack_id).must_equal "USLACKBOT"
        expect(first.real_name).must_equal "Slackbot"
        expect(first.name).must_equal "slackbot"
      end
    end

    it "Returns accurate information about the last user" do
      VCR.use_cassette("user") do
        last = User.list.last
        expect(last.slack_id).must_equal "UN8GKRXK8"
        expect(last.real_name).must_equal "Georgina"
        expect(last.name).must_equal "cpgeorgina.sanchez"
      end
    end
  end

  describe "details" do
    it "returns a hash of details" do
      VCR.use_cassette("user") do
        natalie = User.new("UN8GKRXK8", "Natalie Tapias", "natalie")
        expect(natalie.details).must_be_kind_of Hash
      end
    end

    it "returns accurate information" do
      VCR.use_cassette("user") do
        natalie = User.new("UN8GKRXK8", "Natalie Tapias", "natalie")
        result = natalie.details
        expect(result[:slack_id]).must_equal "UN8GKRXK8"
        expect(result[:real_name]).must_equal "natalie"
        expect(result[:name]).must_equal "Natalie Tapias"
      end
    end
  end
end

