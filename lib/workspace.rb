require_relative 'user'
require_relative 'channel'

module SlackCLI
  class Workspace
    attr_reader :users, :channels
    attr_accessor :selected

    def initialize
      @users = SlackCLI::User.list
      @channels = SlackCLI::Channel.list
      @selected = nil
    end
    
    # def select_user(user)
    # find user by id or name
    # add User to selected 
    # end

    #def find_user(user_name_or_id)
    #take in id or name
    #end

    # def select_channel
    # end


    # def show_details
    # end

    # def send_message
    # end
  end
end
