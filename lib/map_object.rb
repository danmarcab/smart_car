require 'active_support/inflector'

class MapObject
  include ActiveSupport::Inflector

  attr_accessor :info, :x, :y, :width, :length

  def self.create(type, data)
    type.to_s.camelize.constantize.new data
  end

  def initialize(info)
    @info = info
    @x = info[:x]
    @y = info[:y]
  end

  def position
    return @x, @y
  end

  def position= x, y
    @x, @y = x, y
  end

end
