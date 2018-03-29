require './constants'
require './string_extensions'
require './car'

class CarFactory
  include CarConstants
  include StringExtensions

  UnsupportedBrandException = Class.new(StandardError)

  attr_reader :number_of_cars

  def initialize(name, car_brands)
    @name = name
    @car_brands = if car_brands[:brands].is_a?(Array)
                    car_brands[:brands]
                  else
                    [car_brands[:brands]]
                  end

    unless @car_brands.all? { |brand| SUPPORTED_BRANDS.include?(brand) }
      raise UnsupportedBrandException,
            "Brand not supported: '#{to_human(car_brands[:brands])}'"
    end
  end

  def make_car(special_brand = nil)
    if special_brand.nil?
      make_default_car
    else
      make_special_car(special_brand)
    end
  end

  def make_cars(number_of_cars)
    (1..number_of_cars).map do |i|
      make_car(@car_brands[(i - 1) % @car_brands.count])
    end
  end

  def name
    "#{@name} (produces #{@car_brands.map(&:capitalize).join(', ')})"
  end

  private

  def make_default_car
    if @car_brands.count == 1
      Car.new(@car_brands.first)
    else
      raise UnsupportedBrandException,
            'Factory does not have a brand or do not support it'
    end
  end

  def make_special_car(special_brand)
    if @car_brands.include?(special_brand)
      Car.new(special_brand)
    else
      raise UnsupportedBrandException,
            'Factory does not have a brand or do not support it'
    end
  end
end

factory = CarFactory.new('Fiat Bielsko', brands: [:lancia, :subaru])

cars = factory.make_cars(3)