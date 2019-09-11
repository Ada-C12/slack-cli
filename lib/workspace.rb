require_relative 'lib_helper.rb'
require_relative 'user.rb'
require_relative 'recipient.rb'

class Workspace
  
  attr_reader :all_users, :all_channels
  
  def initialize()
    # load all User instances
    @all_users = User.load_all

    # make all Channel instances
    @all_channels = Channel.load_all
  end
  
end