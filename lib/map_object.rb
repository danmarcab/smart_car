require 'active_support/inflector'
require 'matrix'

class MapObject
  include ActiveSupport::Inflector

  attr_accessor :data, :position, :size

  def self.create(type, data = {})
    type.to_s.camelize.constantize.new data
  end

  def initialize(data)
    @data = data
    @position = data[:position].is_a?(Vector) ? data[:position] : Vector[0, 0]
    @size = data[:size].is_a?(Vector) ? data[:size] : Vector[0, 0]
  end

  def center
    @position
  end

  def box
    return @position - half_size, @position + half_size
  end

  def size= size
    @size = size
    @half_size = nil
  end

  private

  def half_size
    @half_size ||= 0.5 * @size
  end

end
