require_relative 'test_helper'
require 'simplecov'
SimpleCov.start


# added for the workspace test
describe "Workspace class" do
  describe "Workspace select_user" do
 
    # Yasmin's updates: but I put select method inside slack.rb? How to test this?
    
#     it "Select user" do
#       VCR.use_cassette("workspace") do
#         # Act
#         user = @users.select_user
#       # user.details
#       expected_output = "#{user}"
#       expect(user).must_equal expected_output
#       end
#     end
#   end
#  # added
#   describe "Workspace select_channel" do
 
#     it "Select channel " do
#       VCR.use_cassette("workspace") do
#         # Act
#         channel = @channels.select_channel
#       # user.details
#       expected_output = "#{channel}"
#       expect(channel ).must_equal expected_output
#       end
#     end
#   end
#  end