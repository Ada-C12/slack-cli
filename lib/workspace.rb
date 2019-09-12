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
    @entity = nil
  end
  
  def show_menu
    choices = { A: "LIST USERS", B: "LIST CHANNELS", C: "SEND MESSAGE", D: "SELECT USER", E: "SELECT CHANNEL", F: "DETAILS", Q: "QUIT" }
    return choices
  end
  
  
  def main_menu(headings: , rows_as_hash: )
    # arg headings: ["head1", "head2", etc] 
    # arg choices_hash: { EX1: "Example1", EX2: "Example2", etc }
    # return table with headings row, and row1 = EX1 | Example1, and row2 = EX2 | Example2, etc
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
  
  def menu_action(choice)
    choice = choice.upcase
    
    case choice
    when "A", "LIST USERS"
      puts show_all_recipients(array_of_recipient_objs: all_users)
      
    when "B", "LIST CHANNELS"
      puts show_all_recipients(array_of_recipient_objs: all_channels)
      
    when "C", "SEND MESSAGE"
      puts "can't do that yet haha"
      
    when "D", "SELECT USER"
      print "Please enter a user's name or id: "
      input = gets.chomp
      begin
        user = select_user(input)
        return user
      rescue => exception
        puts exception.message
        return false
      end
      
      puts "SUCCESS:  User  = #{user.name}"
      
    when "E", "SELECT CHANNEL"
      print "Please enter a channel's name or id: "
      input = gets.chomp
      begin
        channel = select_channel(input)
        return channel
      rescue => exception
        puts exception.message
        return false
      end
      
      puts "SUCCESS:  Channel  = #{channel.name}"
      
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
      puts "k bye"
      exit
    else
      puts "INVALID INPUT, TRY AGAIN"
      return false
    end
    return true
  end  
end