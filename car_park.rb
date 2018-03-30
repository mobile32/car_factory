require './constants'
require './car'

class CarPark
  attr_reader :capacity
  attr_reader :cars

  def initialize(capacity)
    @capacity = capacity
    @cars = []
  end

  def receive(cars)
    if cars.is_a? Car
      @cars.push cars
    elsif cars.is_a? Array
      @cars.push *cars.first(places_left)
    end
  end

  def retrieve(cars)
    @cars.slice! -1, cars
  end

  def brands
    @cars.map(&:brand).uniq
  end

  def brands_stats
    Hash.new(0).tap { |hash| @cars.map(&:brand).each { |brand| hash[brand] += 1 } }
  end

  def places_left
    capacity - @cars.count
  end
end