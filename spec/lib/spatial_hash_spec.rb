require "spec_helper"

describe SpatialHash do

  describe "#initialize" do
    it "sets the cell size" do
      spatial_hash = SpatialHash.new(30)
      spatial_hash.cell_size.should == 30
    end

    it "creates empty hash of cells" do
      spatial_hash = SpatialHash.new(30)
      spatial_hash.cells == {}
    end
  end

  describe "#insert" do
    context "when object fits in one cell" do
      before do
        @spatial_hash = SpatialHash.new(30)
        @object = double('object')
        allow(@object).to receive(:box) { [[1, 1], [2, 2]] }
        @spatial_hash.insert(@object)
      end

      it "inserts the object in the right cell" do
        @spatial_hash.cells[[0, 0]].should include @object
      end

      it "inserts the object only in the right cell" do
        @spatial_hash.cells.length.should == 1
      end
    end

    context "when object lies in multiple cells" do
      before do
        @spatial_hash = SpatialHash.new(30)
        @object = double('object')
        allow(@object).to receive(:box) { [[1, 1], [40, 40]] }
        @spatial_hash.insert(@object)
      end

      it "inserts the object in all the relevant cells" do
        @spatial_hash.cells[[0, 0]].should include @object
        @spatial_hash.cells[[0, 1]].should include @object
        @spatial_hash.cells[[1, 0]].should include @object
        @spatial_hash.cells[[1, 1]].should include @object
      end

      it "inserts the object only in the relevant cells" do
        @spatial_hash.cells.length.should == 4
      end
    end
  end

  describe "#query" do
    context "when two objects in a cell" do
      before do
        @spatial_hash = SpatialHash.new(30)
        @spatial_hash.instance_variable_set(:@cells, {[0, 0] => [:object_1, :object_2]})
        @result = @spatial_hash.query([[1, 1], [2, 2]])
      end

      it "returns both objects" do
        @result.should == [:object_1, :object_2]
      end
    end

    context "when two objects in diffrent cells" do
      before do
        @spatial_hash = SpatialHash.new(30)
        @spatial_hash.instance_variable_set(:@cells, {[0, 0] => [:object_1], [1, 1] => [:object_2]})
      end

      it "returns only the object in the cell we are querying" do
        @result = @spatial_hash.query([[1, 1], [2, 2]])
        @result.should == [:object_1]
      end

      it "returns both objects if querying on both cells" do
        @result = @spatial_hash.query([[1, 1], [40, 40]])
        @result.should == [:object_1, :object_2]
      end
    end

    context "when the same object in several cells" do
      before do
        @spatial_hash = SpatialHash.new(30)
        @spatial_hash.instance_variable_set(:@cells, {[0, 0] => [:object_1, :object_2], [1, 1] => [:object_2]})
        @result = @spatial_hash.query([[1, 1], [40, 40]])
      end

      it "removes duplicated objects" do
        @result.should == [:object_1, :object_2]
      end
    end
  end

end
