require_relative 'test_helper'

# describe "recipient attributes and behaviors" do

describe "recipient attribues" do
  before do
    @test_name = "awesome"
    @slack_id = "0001"
    @test_recipient = Recipient.new(name: @test_name, slack_id: @slack_id)
  end
  it "knows it's an instance of recipient" do
    expect(@test_recipient).must_be_kind_of Recipient
  end
  
  it "knows its slack_id" do
    expect(@test_recipient.id).must_equal @test_id
  end
  
  it "knows its name" do
    expect(@test_recipient.name).must_equal @test_name
  end
  
end

describe "recipient blocks initialization if incorrect format" do
  it "allows initialization with name and id as instances of string to match API" do
    VCR.use_cassette("slack_info") do
      expect{test_recipient = Recipient.new(name: "0001", id: 15.999)}.must_raise ArgumentError
      expect{test_recipient = Recipient.new(name: 0001, id: "15.999")}.must_raise ArgumentError
    end
  end
  
end

describe "fleshed-out methods of being able to provide a detailed summary" do
  it "does not implement a details method" do
    detail_free_recipient = Recipient.new(name: "silly", slack_id: "666")
    expect{detail_free_recipient.details}.must_raise NotImplementedError
  end
end

describe "fleshed-out methods of being able to make a list of instances of itself" do
  it "does not implement a self.list method" do
    expect{Recipient.list}.must_raise NotImplementedError
  end
end



xdescribe "recipient implemented methods" do
  it "responds to needing to send messages" do
    #add guts later, for now, acknowledge request 
  end
  
  it "has a class method to fetch its own URL" do
    # Clara thinks this might be send messages? Who knows? ? 
  end
  
  it "has a class method to fetch its own params" do
    # Clara thinks this might be send messages? Who knows? ? 
  end
  
  
end
