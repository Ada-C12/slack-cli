require 'httparty'
require 'dotenv'

Dotenv.load

BASE_URL = "https://slack.com/api/channels.list"
TOKEN = ENV["API_TOKEN"]

query = {
  token: TOKEN
}

response = HTTParty.get(BASE_URL, query: query)

puts response