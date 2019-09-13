require_relative 'user'
require_relative 'channel'

class Workspace
  
  attr_reader :users, :channels
  attr_accessor :selected
  
  def initialize
    @users = User.get
    @channels = Channel.get
    @selected = nil
    
  end
  
  def select_channel(name_or_id)
    channel = channels.find {|channel| channel.slack_id == name_or_id}
    if channel == nil
      channel = channels.find {|channel| channel.name == name_or_id}
    end
    if channel == nil
      return "Channel does not exist"
    end
    @selected = channel
  end
  
  def select_user(name_or_id)
    user = users.find {|user| user.slack_id == name_or_id}
    if user == nil
      user = users.find {|user| user.name == name_or_id}
    end
    if user == nil
      return "User does not exist"
    end
    @selected = user
  end
  
  def show_details
    if @selected == nil
      return "Please select a user or channel."
    end
    return @selected.details 
  end
  
  def send_message(message: nil)
    if @selected == nil
      puts "You must select a user or channel first"
      return false
    end
    channel = @selected.slack_id
    if message == nil
      puts "Please type your message here:"
      message = gets.chomp
    end
    @selected.send_message(message, channel) 
    # if result == SlackAPIError
    #   return false
    # elsif result == true
    #   reutrn true
    # end
  end
end