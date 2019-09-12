require 'httparty'
require 'awesome_print'
require 'dotenv'
require 'terminal-table'


Dotenv.load


KEY = ENV["SLACK_KEY"]
