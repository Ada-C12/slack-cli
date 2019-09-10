require 'dotenv'
require 'httparty'
require 'awesome_print'
Dotenv.load 

module SlackCli
  class Server
    attr_reader :slack_id, :name

    def initialize(slack_id:, name:)
      @slack_id = slack_id
      @name = name
    end 

    # def self.list
    #   puts "Who knows"
    # end 

  end 

end 