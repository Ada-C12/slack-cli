def main
  
  puts "Welcome to the Ada Slack CLI!"
  # display info about how many channels & user there are 
  # provide 3 options for the user
  puts "Please select from the following options: 
  List Users
  List Channels
  Quit"

  command = gets.chomp.downcase

  if command == "quit"
    exit
  end

 
  puts "Thank you for using the Ada Slack CLI"

end

main if __FILE__ == $PROGRAM_NAME
