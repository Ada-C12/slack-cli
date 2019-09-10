module SlackCLI
  class Workspace
    attr_reader :users, :channels
    attr_accessor :selected

    def initialize
      @users = []
      @channels = []
      @selected = nil
    end
  end
end
