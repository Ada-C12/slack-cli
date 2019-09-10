require_relative 'channel'
require_relative 'user'

class Workspace
  attr_reader :channels, :users, :selected

  def initialize
    @channels = Channel.list
    @users = User.list
    @selected = nil
  end

  def show_details
    puts channels.map(&:details).join('\n')
    puts users.map(&:details).join('\n')
  end
end
