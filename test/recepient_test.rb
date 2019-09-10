require_relative 'test_helper'

# describe "recepient attributes and behaviors" do

describe "recepient attribues" do
  before do
    VCR.use_cassette("slack_info") do
@   test_recepient = Recepient.new 
    end
  end
  
  it "knows it's an instance of recepient" do
    VCR.use_cassette("slack_info") do
    end
  end
  
  it "knows its slack_id" do
    VCR.use_cassette("slack_info") do
    end
  end
  
  it "knows its name" do
    VCR.use_cassette("slack_info") do
    end
  end
  
end

xdescribe "recepient implemented methods" do
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

# MAY NOT NEED ACTUAL TESTING, AS THESE ARE JUST HERE FOR INHERITANCE
xdescribe "recepient abstract methods" do
  # these are useless in this class, they are here to be inhereted from 
  it "is able to create a summary of itself" do
  end
  
  it "is able to create a list of all instances of itself" do
  end
  
end

xdescribe "recepient attributes and behaviors" do
  before do
  end
  
  it "is a test, maybe?" do
    VCR.use_cassette("slack_info") do
    end
    
  end
  
end