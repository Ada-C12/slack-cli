#!/usr/bin/env ruby

def main
  until user_choice == "quit"
    puts "Welcome to the Ada Slack CLI!"
    
    # TODO project
    puts "What would you like to do?"
    puts "1) List user\n2)List channel"
    user_choice = gets.chomp
    
    if user_choice == "1"
      puts "Do you want to:"
      puts "1) See details\n 2) Send a message to the user"
      user_choice = gets.chomp
      if user_choice == "2"
        print "Write your message:> "
        user_choice = gets.chomp
      end
    elsif user_choice == "2"
      puts "Do you want to:"
      puts "1) See details\n 2) Send a message to the channel"
      user_choice = gets.chomp
      if user_choice == "2"
        print "Write your message:> "
        user_choice = gets.chomp
      end
    else
    end
    
    puts "Thank you for using the Ada Slack CLI"
  end
end

main if __FILE__ == $PROGRAM_NAME