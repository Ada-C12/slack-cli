require_relative 'test_helper'



  describe 'send message' do
    before do
      VCR.use_cassette("recipient.send_message") do
        query_parameters = {
          token: ENV['SLACK_KEY']
        }
        @users_json = SlackCLI::Recipient.get('https://slack.com/api/users.list',query: query_parameters)
      end
      @users = SlackCLI::User.json_parse(@users_json)
    end
    
    it 'creates an array' do
      expect(@users).must_be_kind_of Array
    end
end