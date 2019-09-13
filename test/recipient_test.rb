require_relative 'test_helper'

describe "recipent class tests" do 
  before do 
    @selected_recipient =  SlackCli::User.new(
      name: "monick.keo",
      real_name: "monick.keo",
      id: "UN8JZT96J"
    )
    @message = "IT WORKS!"
  end 

  it "should send a message to selected recipient" do 
    VCR.use_cassette("slack_details") do
      test = SlackCli::Recipient.send_message(recipient:@selected_recipient.id, message:@message)
      expect(test.code).must_equal 200
      expect(test.body).must_include "IT WORKS!"
    end 
  end 
end 
