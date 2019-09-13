require_relative 'lib_helper.rb'
require_relative 'user.rb'
require_relative 'recipient.rb'

class Workspace
  
  attr_reader :all_users, :all_channels
  attr_accessor :entity
  
  def initialize()
    # load all User instances
    @all_users = User.load_all
    
    # make all Channel instances
    @all_channels = Channel.load_all
    
    # default entity (user or channel) selection to nil
    @entity = nil
  end
  
  def menu_choices_hash
    choices = { A: "LIST USERS", B: "LIST CHANNELS", C: "SEND MESSAGE", D: "SELECT USER", E: "SELECT CHANNEL", F: "DETAILS", Q: "QUIT" }
    return choices
  end
  
  def main_menu(headings: , rows_as_hash: )
    # arg headings: ["head1", "head2", etc] 
    # arg choices_hash: { ROW1: "Example R1", ROW: "Example R2", etc }
    rows = [] 
    rows_as_hash.each do |key, value|
      row = [key, value]
      rows << row
    end
    
    table = Terminal::Table.new(headings: headings, rows: rows )
    return table
  end
  
  def get_all_users_details
    all_users_details = []
    @all_users.each do |user_obj|
      details = user_obj.details
      all_users_details << details
    end
    return all_users_details
  end
  
  def get_all_channels_details
    all_channels_details = []
    @all_channels.each do |channel_obj|
      details = channel_obj.details
      all_channels_details << details
    end
    return all_channels_details
  end
  
  def select_user(input)
    input = input.upcase
    
    @all_users.each do |user|
      if (input == user.id) || (input == user.name.upcase)
        return user
      end
    end
    raise ArgumentError.new("Inputed user doesn't exist")
    
  end
  
  def select_channel(input)
    input = input.upcase
    
    @all_channels.each do |channel|
      if (input == channel.id) || (input == channel.name.upcase)
        return channel
      end
    end
    raise ArgumentError.new("Inputed channel doesn't exist")
    
  end
  
  def show_all_recipients(array_of_recipient_objs:, enumerate:true)
    if enumerate
      headings = [""]
    else
      headings = []
    end
    all_keys = array_of_recipient_objs[0].details.keys
    all_keys.each do |key|
      headings << key.to_s.upcase
    end
    
    rows_in_array = []
    count = 0
    array_of_recipient_objs.each do |recipient_obj|
      if enumerate
        row = ["#{(count+65).chr}"]
      else
        row = []
      end
      details = recipient_obj.details
      details.each do |key, value|
        row << value
      end
      
      rows_in_array << row
      count += 1
    end
    
    return Terminal::Table.new(headings: headings , rows: rows_in_array)
  end
  
  def send_message
    url = "https://slack.com/api/chat.postEphemeral"
    begin
      msg_recipient = get_msg_recipient
    rescue => exception
      puts exception.message
      return false
    end
    
    text = get_text
    query_params = { token: ENV["SLACK_KEY"], channel: "CN69B7XMW", text: text, user: msg_recipient.id}
    response = HTTParty.get(url, query: query_params)
    sleep(0.25)
    
    if response["ok"] == true
      return response
    else
      raise SlackAPIError, "API request failed"
    end
  end
  
  def get_msg_recipient
    # use if entity , else send back to main menu
    if entity
      return entity
    else
      raise SlackAPIError, "You must select a recipient user via Main Menu"
    end 
  end
  
  def get_text
    print "What is your message?\n>>> "
    text = gets.chomp
    return text
  end
  
  def menu_action(choice)
    choice = choice.upcase
    
    case choice
    when "A", "LIST USERS"
      puts show_all_recipients(array_of_recipient_objs: all_users)
      
    when "B", "LIST CHANNELS"
      puts show_all_recipients(array_of_recipient_objs: all_channels)
      
    when "C", "SEND MESSAGE"
      puts "SENDING MESSAGE"
      send_message
      
    when "D", "SELECT USER"
      print "Please enter a user's name or id: "
      input = gets.chomp
      begin
        user = select_user(input)
        puts "SUCCESS:  User  = #{user.name}"
        return user
      rescue => exception
        puts exception.message
      end
      
    when "E", "SELECT CHANNEL"
      print "Please enter a channel's name or id: "
      input = gets.chomp
      begin
        channel = select_channel(input)
        puts "SUCCESS:  Channel  = #{channel.name}"
        return channel
      rescue => exception
        puts exception.message
      end
      
    when "F", "DETAILS"
      puts "SHOWING DETAILS"
      
      begin
        unless (entity.class == User) || (entity.class == Channel)
          raise ArgumentError.new("No user or channel selected")
        end
        puts show_all_recipients(array_of_recipient_objs:[@entity], enumerate: false)
      rescue => exception
        puts exception.message
      end
      
    when "Q", "QUIT"
      puts "\nThank you for using the Ada Slack CLI\n\n"
      exit
    else
      puts "INVALID INPUT, TRY AGAIN"
      return false
    end
    return true
  end  
end