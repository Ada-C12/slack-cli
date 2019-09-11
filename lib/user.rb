require 'httparty'

class User < Recipient
<<<<<<< HEAD
  URL = 'https://slack.com/api/users.list'
  KEY = ENV['SLACK_API_TOKEN']

    attr_reader :slack_id, :name, :real_name
    @@users_list = []
=======
  attr_reader :slack_id, :name, :real_name
  @@users_list = []
>>>>>>> fc314b644f484bcafa1efd1eb1531638e94b2c51

  def initialize(slack_id, name, real_name)
    super(slack_id, name) 
    @real_name = real_name
    @@users_list << self
  end

<<<<<<< HEAD
    def self.list
      query = {
        token: KEY
      }
      response = HTTParty.get(URL, query: query)
      return response
    end
=======
  def self.list
    return @@users_list
  end
>>>>>>> fc314b644f484bcafa1efd1eb1531638e94b2c51

end