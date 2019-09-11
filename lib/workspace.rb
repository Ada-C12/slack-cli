require_relative 'channel'
require_relative 'user'

class Workspace
  attr_reader :channels, :users, :selected
  
  def initialize
    @channels = Channel.list
    @users = User.list
    @selected = nil
  end
  
  def show_details *recipients
    recipients = [:channels, :users] if recipients.empty?
    
    recipients.each do |recipient|
      puts recipient.capitalize
      puts self.send(recipient).map(&:details).join("\n")
    end
  end
  
  def find_recipient(list:, name: nil, slack_id: nil)
    raise ArgumentError unless name || slack_id

    return list.find do |recipient| 
      name ? recipient.name == name : recipient.slack_id == slack_id  
    end 
  end
end
