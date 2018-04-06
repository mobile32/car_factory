require './car'

class CarPark
  attr_reader :capacity, :cars

  def initialize(capacity)
    @capacity = capacity
    @cars = []
  end

  def receive(cars)
    if cars.is_a? Car
      self.cars.push cars
    elsif cars.is_a? Array
      self.cars.push *cars.first(places_left)
    end
  end

  def retrieve(number_of_cars)
    cars.pop(number_of_cars)
  end

  def brands
    cars.map(&:brand).uniq
  end

  def brands_stats
    cars.map(&:brand).each_with_object(Hash.new(0)) do |brand, stats|
      stats[brand] += 1
    end
  end

  def places_left
    capacity - cars.count
  end
end