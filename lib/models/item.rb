require 'pry'

class Item
  # attrs here
  attr_reader :type

  # initialize here
  def initialize()
    @type = get_type
  end

  # other methods here
  def get_type
    types = Dir["public/img/items/*.jpg"].collect {|s| s.gsub("public/img/items/", "").gsub(".jpg", "") } 
    types[rand(types.count)]
  end

  def format_type
    type.gsub('_', ' ').split.map(&:capitalize).join(' ')
  end
end