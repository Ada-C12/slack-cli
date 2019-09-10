require_relative "test_helper"
require 'dotenv'
require 'httparty'

Dotenv.load

describe "Recipient" do
  before do
    VCR.use_cassette("location_find") do
    slack_id = "1232452"
    name = "Dominique"
    @recipient = Recipient.new(slack_id, name)
    # @response = Recipient.get_information(URL,)
    end
  end

  describe "Recipient instantiation" do
    it "is an instance of Recipient " do
      expect(@recipient).must_be_kind_of Recipient
    end
  end

  describe "get_information" do
    it "raises an error if invoked directly (without subclassing)" do
      url = "https://slack.com/api/channels.list"
      query = {token: 347358792354398}

      expect {
      Recipient.get_information(url, query)
      }.must_raise NotImplementedError
    end
  end

  describe "list_information" do
    it "raises an error if invoked directly (without subclassing)" do
      
      expect {
        Recipient.get_list
        }.must_raise NotImplementedError
    end
  end

end

  # describe "get_information" do
  #   it "gets response from server (JSON)" do
  #     #Arrange
  #     url = "https://slack.com/api/channels.list"
  #     query = {token: ENV['SLACK_TOKEN']}
  #     #Act
  #     response = Recipient.get_information(url, query)

  #     #Assert
  #     expect(response).must_be_instance_of HTTParty::Response
  #   end
  # end

# end