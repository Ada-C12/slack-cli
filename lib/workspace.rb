require_relative 'lib_helper.rb'
require_relative 'user.rb'
require_relative 'recipient.rb'

class Workspace
  
  attr_reader :all_users, :all_channels
  
  def initialize()
    # make all User instances
    @all_users = []
    giant_hash = User.users_in_giant_hash
    giant_hash.each do |key, value|
      id = key
      name = value[:name]
      real_name = value[:real_name]
      @all_users << User.new(id: id, name: name, real_name: real_name)
    end
    
    # make all Channel instances
    @all_channels = []
    giant_hash = Channel.channels_in_giant_hash
    giant_hash.each do |key, value|
      id = key
      puts "using Id = #{id}"
      name = value[:name]
      topic = value[:topic]
      member_count = value[:member_count]
      @all_channels << Channel.new(id:id, name:name, topic: topic, member_count: member_count)
    end
  end
  
end