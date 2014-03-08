class SpatialHash

  attr_reader :cell_size, :cells

  def initialize(cell_size)
    @cell_size = cell_size
    @cells = {}
  end

  def insert(object)
    get_cells(object.box).each do |cell|
      @cells[cell] ||= []
      @cells[cell].push object
    end
  end

  def query(box)
    objects = []
    get_cells(box).each do |cell|
      objects.push @cells[cell]
    end
    objects.flatten.compact.uniq
  end

  private

  def get_cell(point)
    return point[0]/self.cell_size, point[1]/self.cell_size
  end

  def get_cells(box)
    box = box.map { |point| get_cell(point) }
    x_range = (box[0][0]..box[1][0]).to_a
    y_range = (box[0][1]..box[1][1]).to_a

    x_range.product y_range
  end
end
