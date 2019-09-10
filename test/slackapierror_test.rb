require_relative 'test_helper.rb'

describe "is SlackAPIError working?" do
  
  it "is SlackAPIError an instance of StandardError?" do
    p SlackAPIError.superclass
    assert(SlackAPIError.superclass == StandardError)
  end
  
  it "can we successfuly raise it?" do
    def tryThis
      if true
        raise SlackAPIError, "hahaha"
      end
    end
    expect{ tryThis }.must_raise SlackAPIError
  end
  
end