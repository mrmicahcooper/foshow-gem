require 'spec_helper'
require 'foshow'

describe Foshow do

  describe ".configure" do

    before do
      Foshow.configure do |config|
        config.views = ['stub']
      end
    end

    it "stores the configured values at the class level" do
      Foshow.instance.config.views.should == ['stub']
    end

  end

end
