require 'yaml'
require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/hash_with_indifferent_access'

class Map
  attr_accessor :width, :length, :cell_size, :objects

  def load(file)
    map_info = HashWithIndifferentAccess.new(YAML::load(File.open(File.expand_path(file))))

    map_info.each do |key, value|
      self.send("#{key}=", value)
    end

    @spatial_hash = SpatialHash.new(cell_size)

    objects.each do |object_id, object|
      object = object.each do |k, v|
        object[k] = Vector.elements(v) if v.is_a?(Array)
      end
      objects[object_id] = MapObject.create(object['type'], object)
      @spatial_hash.insert objects[object_id]
    end

    self
  end

  def search_objects box
    @spatial_hash.query(box)
  end
end
