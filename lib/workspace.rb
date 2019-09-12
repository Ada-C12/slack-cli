require 'dotenv'
Dotenv.load

class Workspace
  def initialize(users, channels, selected: nil)
    @users = users
    @channels = channels
    @selected = selected 
  end
end