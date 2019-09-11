require "httparty"
require "awesome_print"
require_relative "workspace"

def main
  puts "Welcome to the Ada Slack CLI!"
  @workspace = Slack::Workspace.new() 
  p @workspace.users[4]
  p @workspace.channels
  
  # TODO project

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME

