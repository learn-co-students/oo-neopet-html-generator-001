require 'pry'
class User
  # attrs here
  attr_reader :name
  attr_accessor :neopoints, :items, :neopets

  PET_NAMES = ["Angel", "Baby", "Bailey", "Bandit", "Bella", "Buddy", "Charlie", "Chloe", "Coco", "Daisy", "Lily", "Lucy", "Maggie", "Max", "Molly", "Oliver", "Rocky", "Shadow", "Sophie", "Sunny", "Tiger"]

  # initialize here
  def initialize(name)
    @name = name
    @neopoints = 2500
    @items = []
    @neopets = []
  end

  # other methods here
  def select_pet_name
    PET_NAMES[rand(PET_NAMES.count)]
  end
 
  def make_file_name_for_index_page
    @name.gsub(' ', '-').downcase
  end

  def buy_item
    if @neopoints >= 150
      @neopoints -= 150
      item = Item.new()
      @items << item
      "You have purchased a #{item.type}."
    else
      "Sorry, you do not have enough Neopoints."
    end
  end

  def find_item_by_type(type)
    @items.each do |item|
      if item.type == type
        return item
      else
        return nil
      end
    end
  end

  def buy_neopet
    if @neopoints >= 250
      @neopoints -= 250
      neopet = Neopet.new(select_pet_name)
      @neopets << neopet
      "You have purchased a #{neopet.species} named #{neopet.name}."
    else
      "Sorry, you do not have enough Neopoints."
    end
  end

  def find_neopet_by_name(name)
    @neopets.each do |pet|
      if pet.name == name
        return pet
      end
    end

    return nil
  end

  def sell_neopet_by_name(name)
    pet = find_neopet_by_name(name)
    if pet == nil
      return "Sorry, there are no pets named #{name}."
    else
      @neopets.delete(pet)
      @neopoints += 200
      return "You have sold #{name}. You now have #{@neopoints} neopoints."
    end
  end

  def feed_neopet_by_name(name)
    pet = find_neopet_by_name(name)
    if pet == nil
      return "Sorry, there are no pets named #{name}."
    else
      if pet.mood != "ecstatic"
        pet.happiness += 2
      elsif pet.happiness == 9
        pet.happiness = 10
      elsif pet.happiness == 10
        return "Sorry, feeding was unsuccessful as #{pet.name} is already ecstatic."
      end
      return "After feeding, #{pet.name} is #{pet.mood}."
    end
  end

  def give_present(present, name)
    item = find_item_by_type(present)
    pet = find_neopet_by_name(name)

    if item == nil && pet == nil
      return "Sorry, an error occurred. Please double check the item type and neopet name."
    elsif item == nil
      return "Sorry, an error occurred. Please double check the item type and neopet name."
    elsif pet == nil
      return "Sorry, an error occurred. Please double check the item type and neopet name."
    else   
      @items.delete(item)
      pet.items << item
      pet.happiness += 5
      if pet.happiness > 10
        pet.happiness = 10
      end
      return "You have given a #{item.type} to #{pet.name}, who is now #{pet.mood}."
    end
  end

  def make_index_page
    methods = [:name, :mood, :species, :strength, :defence, :movement]
    index = File.open("./views/users/#{make_file_name_for_index_page}.html", 'w')
    index.puts "<!DOCTYPE html>"
    index.puts "<html>"
    index.puts "<head><title>#{@name}</title></head>"
    index.puts "<body>"
    index.puts "<h1>#{@name}</h1>"
    index.puts "<h3><strong>Neopoints:</strong> #{@neopoints}</h3>"
    index.puts "<h3>Neopets</h3>"
    @neopets.each do |pet|
      index.puts "<img src=\"../../public/img/neopets/#{pet.species}.jpg\">"
      index.puts "<ul>"
      methods.each do |method|
        index.puts "<li><strong>#{method.to_s.capitalize}:</strong> #{pet.send(method)}</li>"
      end
      index.puts "</ul>"
    end
    index.puts "<h3>Items</h3>"
    index.puts "<ul>"
    @items.each do |item|
      index.puts "<img src=\"../../public/img/items/#{item.type}.jpg\">"
      index.puts "<li><strong>Type:</strong> #{item.format_type}</li>"
    end
    index.puts "</ul>"
    index.puts "</body></html>"
    index.close
  end
end