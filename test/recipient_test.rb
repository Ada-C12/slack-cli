require_relative 'test_helper'

describe 'class recipient' do
  describe 'initialize' do 
    let(:recipient){
      Slack::Recipient.new(id: "C0G9QF9GW", name: "Xinran")
    }
    
    it 'creates a new instance of Recipient' do
      expect(recipient).must_be_instance_of Slack::Recipient
    end
    
    it 'accurately stores slack_id' do
      expect(recipient.id).must_be_instance_of String
      expect(recipient.id).must_equal "C0G9QF9GW"
    end
    
    it 'accurately stores name' do
      expect(recipient.name).must_be_instance_of String
      expect(recipient.name).must_equal "Xinran"
    end
    
    
  end
end