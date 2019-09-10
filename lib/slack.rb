require_relative "user"
# require_relative ""
# require_relative ""

def main
  
  puts "Welcome to the Ada Slack CLI!"
  # display info about how many channels & user there are 
  # provide 3 options for the user
  puts "Please select from the following options: 
  List Users
  List Channels
  Quit"

  command = gets.chomp.downcase

  # loop through if user inputs  aljdflkasdf
  # if command == "quit"
  #   exit
  # elsif command == "list users"
  # elseif 
  case command
  when "quit"
    exit
  when "list users"
    Slack::User.print_list
  when "list channels"
  end

 
  puts "Thank you for using the Ada Slack CLI"

end

main if __FILE__ == $PROGRAM_NAME
