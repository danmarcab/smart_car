require "spec_helper"

describe Map do
  it { should respond_to :width }
  it { should respond_to :length }
  it { should respond_to :objects }
  it { should respond_to :load }

  describe "#load" do
    before do
      @map = Map.new
      @map.load('spec/fixtures/map.yml')
    end

    it "sets the width" do
      @map.width.should be_a Numeric
    end

    it "sets the length" do
      @map.length.should be_a Numeric
    end

    it "sets the objects" do
      @map.objects.should be_a Hash
    end

    it "sets the objects" do
      @map.objects.each { |object_id, object| object.should be_a MapObject }
    end
  end
end
