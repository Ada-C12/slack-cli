require_relative 'test_helper'

 describe "Channel Class"do
 
  describe "self.list method" do
    it "should return true if the list was returned" do
      VCR.use_cassette("channel-tests") do
        response = Channel.list
        expect(response["ok"]).must_equal true
      end
    end
  end
end