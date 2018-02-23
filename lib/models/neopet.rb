class Neopet
  # attrs here
  attr_reader :name, :species, :strength, :defence, :movement
  attr_accessor :happiness, :items

  # initialize here
  def initialize(name="")
    @name = name
    @items = []
    @strength = get_points
    @defence = get_points
    @movement = get_points
    @happiness = get_points
    @species = get_species
  end

  # other methods here
  def get_points
    rand(10) + 1
  end

  def get_species
    species = Dir["public/img/neopets/*.jpg"].collect {|s| s.gsub("public/img/neopets/", "").gsub(".jpg", "") } 
    species[rand(species.count)]
  end

  def mood
    if @happiness < 3
      "depressed"
    elsif @happiness < 5
      "sad"
    elsif @happiness < 7
      "meh"
    elsif @happiness < 9
      "happy"
    else
      "ecstatic"
    end
  end
end