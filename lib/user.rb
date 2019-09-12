require 'httparty'
require 'dotenv'
Dotenv.load
require 'pry'
require 'table_print'
class User < Recipient
  attr_reader :slack_id, :name, :real_name
  @@users_list = []
  BASE_URL = "https://slack.com/api/users.list"
  API_KEY = ENV['SLACK_API_TOKEN']
  
  def initialize(slack_id, name, real_name)
    super(slack_id, name) 
    @real_name = real_name
    @@users_list << self
  end
  
  def self.list
    query = {
      token: API_KEY
    }
    response = HTTParty.get(BASE_URL, query: query)
    return response
  end
  
  def self.printed_users_list
    users_array = []
    self.list["members"].each do |member|
      users_array << {"User Name" => member["name"],"Real Name" => member["real_name"],"Slack ID"=> member["id"]}
    end
    puts users_array
  end

  def self.select_user(desired_person)

    self.printed_users_list.each do |user|
      if user["User Name"] == desired_person
        return desired_person
      elsif user["Slack ID"] == desired_person
        return desired_person
      else
        return nil
      end
    end
  end

end