require 'csv'

module Parsing
  def self.parse_csv(filename, object_class)
    container = []
    CSV.readlines(filename).map do |object_data|
      container << object_class.new(*object_data)
    end
    return container
  end
end

class Motorcycle

  attr_reader :color, :year, :brand

  def initialize(color, year, brand)
    @color = color
    @year = year.to_i
    @brand = brand
  end
end

class Dealership

  attr_reader :vehicles

  def initialize
    @vehicles = []
    self.load
  end

  # def load
  #   CSV.readlines('bikes.csv').map do |object_data|
  #     @vehicles << Motorcycle.new(*object_data)
  #   end
  # end

  def load
    @vehicles = Parsing::parse_csv('bikes.csv', Motorcycle)
  end

  def query(color, year, brand)
    found_matches = vehicles.count {|bike| bike.color == color && bike.year==year && bike.brand == brand}
  end

end

dealership = Dealership.new
p dealership.vehicles.count
p dealership.vehicles.count {|bike| bike.year > 2010}
p dealership.vehicles.count {|bike| bike.brand == 'Honda' || bike.brand == 'Suzuki'}
p dealership.query("white",2009,"BMW")