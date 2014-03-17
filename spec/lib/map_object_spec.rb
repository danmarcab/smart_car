require "spec_helper"

describe MapObject do
  subject { MapObject.new({}) }
  it { should respond_to :position }
  it { should respond_to :size }

  describe ".create" do
    before do
      @data = {}
      @object = MapObject.create(:building, @data)
    end

    it "creates an instance of the subtype" do
      @object.should be_a Building
    end

    it "creates an instance of the subtype" do
      @object.data.should == @data
    end

    context "when position attributes passed" do
      before do
        @data = { position: Vector[1, 1] }
        @object = MapObject.create(:building, @data)
      end

      it "sets the position" do
        @object.position.should == @data[:position]
      end
    end

    context "when size attributes passed" do
      before do
        @data = { size: Vector[1, 1] }
        @object = MapObject.create(:building, @data)
      end

      it "sets the size" do
        @object.size.should == @data[:size]
      end
    end
  end

  describe "#center" do
    before do
      @data = { position: Vector[1, 1] }
      @object = MapObject.create(:building, @data)
    end

    it "returns the center" do
      @object.center.should == @data[:position]
    end
  end

  describe "#box" do
    before do
      @data = { position: Vector[0, 0], size: Vector[1, 1] }
      @object = MapObject.create(:building, @data)
    end

    it "returns the bounding box" do
      @object.box.should == [Vector[-0.5, -0.5], Vector[0.5, 0.5]]
    end
  end

end
