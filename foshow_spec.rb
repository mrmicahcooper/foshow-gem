require 'spec_helper'
require 'foshow'

describe Foshow do
  describe ".new" do
    let(:foshow) { Foshow.new }
    context
    it "creates a new Foshow object" do
      foshow.should_not.be_nil?
    end
  end
end
