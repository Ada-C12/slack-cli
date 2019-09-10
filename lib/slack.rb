#!/usr/bin/env ruby

require_relative 'workspace'

COMMANDS = ['list users', 'list channels', 'quit']

def show_commands
  puts "Available commands:"
  puts COMMANDS
end

def get_command
  input = gets.chomp.downcase until COMMANDS.include? input
  return input
end

def main
  puts "Welcome to the Ada Slack CLI!\n"

  workspace = Workspace.new
  workspace.show_details

  while true
    show_commands
    command = get_command

    case command
      when 'quit'
        break
        
      when 'list users'
        workspace.users.each do |user|
          puts user.details
        end
        
      when 'list channels'
        workspace.channels.each do |channel|
          puts channel.details
        end
    end
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
