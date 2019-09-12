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
  
  def menu_action(choice)
    choice = choice.upcase
    
    case choice
    when "A", "LIST USERS"
      rows_in_array = []
      get_all_users_details.each_with_index do |user_hash, index|
        row = ["#{(index+65).chr}", "#{user_hash[:id]}", "#{user_hash[:name]}", "#{user_hash[:real_name]}"]
        rows_in_array << row
      end
      
      puts Terminal::Table.new(headings: ["", "ID", "NAME", "REAL NAME"] , rows: rows_in_array)
      
    when "B", "LIST CHANNELS"
      puts get_all_channels_details
      rows_in_array = []
      get_all_channels_details.each_with_index do |channel_hash, index|
        row = ["#{(index+65).chr}", "#{channel_hash[:id]}", "#{channel_hash[:name]}", "#{channel_hash[:topic]}", "#{channel_hash[:member_count]}"]
        rows_in_array << row
      end
      
      puts Terminal::Table.new(headings: ["", "ID", "NAME", "TOPICS", "MEMBER COUNT"] , rows: rows_in_array)
      
      
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
        if @entity.class == User
        user_result = @entity.details
        row = ["#{user_result[:id]}", "#{user_result[:name]}", "#{user_result[:real_name]}"]
        
        puts Terminal::Table.new(headings: ["ID", "NAME", "REAL NAME"] , rows: [row])
        
      elsif @entity.class == Channel
        channel_result = @entity.details
        row = ["#{channel_result[:id]}", "#{channel_result[:name]}", "#{channel_result[:topic]}",  "#{channel_result[:member_count]}"]
        puts Terminal::Table.new(headings: ["ID", "NAME", "TOPIC", "MEMBER COUNT"] , rows: [row])
      else
        raise ArgumentError.new("No entity selected")
      end
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