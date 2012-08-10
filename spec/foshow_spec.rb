require "spec_helper"
require "foshow"
require 'ostruct'

describe Foshow do
  let(:foshow) { Foshow.instance }
  let(:renderer) { double('content_tag').as_null_object.and_return("cool") }

  describe ".configure" do

    before do
      Foshow.configure do |config|
        config.views = ["stub"]
      end
    end

    it "stores the configured values at the class level" do
      foshow.config.views.should == ["stub"]
    end

  end

  describe ".render" do
    it "passes the renderer to the instance" do
      foshow.should_receive(:render)
      Foshow.render(renderer)
    end
  end

  describe "#config" do
    it "stores configuration in an openstruct" do
      foshow.config.class.should == OpenStruct
    end
  end

  describe "#render" do
    it 'returns a content tag' do
      foshow.render.should_not be_nil
    end
  end

end
