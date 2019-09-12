require 'dotenv'
Dotenv.load
require_relative 'lib/slack_api_wrapper'

SlackApi.send_msg("Hi there!", "sploots")