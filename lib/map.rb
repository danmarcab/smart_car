require 'yaml'

class Map
  attr_accessor :width, :length, :objects

  def load(file)
    map_info = YAML::load(File.open(File.expand_path(file)))

    map_info.each do |key, value|
      self.send("#{key}=", value)
    end

    objects.each do |object_id, object|
      objects[object_id] = MapObject.create(object['type'], object)
    end
  end
end
