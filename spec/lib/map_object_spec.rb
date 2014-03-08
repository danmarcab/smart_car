require "spec_helper"

describe MapObject do
  subject { MapObject.new({}) }
  it { should respond_to :x }
  it { should respond_to :y }
  it { should respond_to :width }
  it { should respond_to :length }

  describe ".create" do
    before do
      @info = {}
      @object = MapObject.create(:building, @info)
    end

    it "creates an instance of the subtype" do
      @object.should be_a Building
    end

    it "creates an instance of the subtype" do
      @object.info.should == @info
    end

    context "when position attributes passed" do
      before do
        @info = { x: 1, y: 1 }
        @object = MapObject.create(:building, @info)
      end

      it "sets the position" do
        @object.position.should == [@info[:x], @info[:y]]
      end
    end
  end

end
