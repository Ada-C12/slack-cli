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

  def show_menu
    choices = { A: "LIST USERS", B: "LIST CHANNELS", C: "SEND MESSAGE", Q: "QUIT" }
    return choices
  end

  def eval_choice(choice)
    choice = choice.upcase

    case choice
    when "A", "LIST USERS"
      #todo
    when "B", "LIST CHANNELS"
      #todo
    when "C", "SEND MESSAGE"
      puts "can't do that yet haha"
    when "Q", "QUIT"
      puts "k bye"
      exit
    else
      return false
    end
  end


  # invalid?  show menu again
  
  end

  def list_users
  end

  def list_channels
  end

  


  
end