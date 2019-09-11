require 'dotenv'
require 'httparty'
require 'awesome_print'
Dotenv.load 

module SlackCli
  class Recipient
    attr_reader :id, :name

    def initialize(id:, name:)
      @id = id
      @name = name
    end 

    # def self.list
    #   puts "Who knows"
    # end 

  end 

end 