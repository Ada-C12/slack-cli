require_relative 'lib_helper.rb'
require_relative 'recipient'

class User < Recipient
  attr_reader :real_name
  
  def initialize(id:, name:, real_name:)
    @id = id
    @name = name
    @real_name = real_name
  end

   def self.get_raw_data
    url = "https://slack.com/api/users.list"
    query_params = { token: KEY }
    response = HTTParty.get(url, query: query_params)
    p response["ok"]
    sleep(0.5)
    return response
  end

  
  def details
    
  end

  def self.list
    response = get_raw_data
    return response
  end

  def self.get_real_names
    response = (self.list)["members"]
    all_real_names = response.map do |member_info|
      member_info["real_name"]
    end
    return all_real_names
  end

  def self.get_names
    response = (self.list)["members"]
    all_names = response.map do |member_info|
      member_info["name"]
    end
    return all_names
  end

  def self.get_ids
    response = (self.list)["members"]
    all_ids = response.map do |member_info|
      member_info["id"]
    end
    return all_ids
  end

  def self.users_in_array
    real_names = self.get_real_names
    names = self.get_names
    ids = self.ids
    array = []
    if real_names

  
 
  

  
end