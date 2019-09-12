#lib/slack.rb
require "httparty"
require "awesome_print"
require_relative "workspace"

def main
  puts "Welcome to the Ada Slack CLI!"
  @workspace = Slack::Workspace.new() 
  @workspace.users
  @workspace.channels
  @workspace.select_user("UMTERDBPU")
  # @workspace.select_channel("CMUPUL1R9")
  p @workspace.show_details
  
  
  # TODO project

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME

