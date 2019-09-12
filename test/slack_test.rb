require_relative 'test_helper'

xdescribe "SlackSpace instantiate" do 
  before do 
    @slack = SlackCli::SlackSpace.new()
  end 

  it "should instanitate as SlackCli::SlackSpace" do
   expect(@slack).must_be_kind_of SlackCli::SlackSpace
  end 
end 

xdescribe "start_program method should run menu" do 
  before do 
    @slack = SlackCli::SlackSpace.new()
  end 

  it "welcome message displays with menu items and returns user_input" do 
    VCR.use_cassette("slack_details") do
     expect(@slack.welcome('list channels')).must_be_kind_of String
    end 
  end 

  xit "if user wants to list users, list of users is printed" do 
    VCR.use_cassette("slack_details") do
     #if user_input is list users, User.list should be returened 
    end 
  end 

  xit "if user wants to list channels, list of channels is printed" do 
    VCR.use_cassette("slack_details") do
      #if user_input is list channels, User.list should be returened 
    end 
  end 

  xit "if user does not select/type a correct item, raise argumenterror" do 
    VCR.use_cassette("slack_details") do
     
    end
  end 

  xit "returns to main menu when completing a task" do 
    VCR.use_cassette("slack_details") do
      
    end 
  end 

  xit "quits program when user types 'quit'" do 
    VCR.use_cassette("slack_details") do
      
    end 
  end 
end 