require_relative "workspace"
require_relative "user"
require_relative "channel"
require_relative "acceptor"

def main
  
  puts "Welcome to the Ada Slack CLI!"
  # TO-DO: Display total count of users and channels

  prompt = "Please select from the following options: 
  List Users
  List Channels
  Quit"

  puts prompt
  
  while command = gets.chomp.downcase
    case command
    when "quit"
      exit
    # when "list users"
      # TO-DO: call print_list method for user
      # break - to avoid asking for more input
    # when "list channels"
      # TO-DO: call print_list method for channel
      # break - to avoid asking for more input
    else
      puts "Error: Invalid selection. Returning to main menu...."
      puts prompt
    end
  end
  puts "Thank you for using the Ada Slack CLI"

end

main if __FILE__ == $PROGRAM_NAME

