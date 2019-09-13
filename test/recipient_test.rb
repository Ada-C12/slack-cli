require_relative 'test_helper'

describe "recipent class tests" do 
  before do 
    @selected_recipient =  SlackCli::User.new(
      name: "monick.keo",
      real_name: "monick.keo",
      id: "UN8JZT96J"
    )
    message = "IT WORKS!"
  end 

  it "should send a message to selected recipient" do 
    VCR.use_cassette("slack_details") do
      expect(SlackCli::Recipient.send_message(channel:@selected_recipient.id, text:message)).must_equal "IT WORKS!"
    end 
  end 
end 
