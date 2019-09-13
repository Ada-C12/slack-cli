require_relative 'recepient'

module Slack
  class Workspace 
    attr_reader :users, :channels
    def initialize
      @users = []
      @channels = []
    end
    
    # create method for 'select user/channel'. If recepient of selection does not exist, raise exception/nil 
    # tests needed 
    def select
      
      
    end
  end 
end

