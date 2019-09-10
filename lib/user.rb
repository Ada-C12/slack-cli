BASE_URL = "https://slack.com/api/users.list"
TOKEN = ENV["API_TOKEN"]

query = {
  token: TOKEN
}

response = HTTParty.get(BASE_URL, query: query)

class User
  def initialize(id, username, real_name)
    @id = id
    @username = username
    @real_name = real_name
  end
end