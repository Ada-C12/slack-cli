require_relative 'lib_helper.rb'
require_relative 'recipient'

class User < Recipient
  attr_reader :real_name
  
  def initialize(id:, name:, real_name:)
    # making instances in workspace.rb
    @id = id
    @name = name
    @real_name = real_name
  end

  def details
    return {id: id, name: name, real_name: real_name}
  end

  def self.get_raw_data
    url = "https://slack.com/api/users.list"
    params = { token: KEY }
    response = self.get(url, params)
    p response["ok"]
    sleep(0.5)
    return response
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

  def self.users_in_giant_hash
    real_names = self.get_real_names
    names = self.get_names
    ids = self.get_ids
    results = {}
    unless (real_names.length == names.length) && (names.length == ids.length)
      raise ArgumentError, "All the arrays should have same length!"
    end

    ids.length.times do |index|
      results[ids[index]] = { name: names[index], real_name: real_names[index]}
    end
    return results
  end

  
 
  

  
end