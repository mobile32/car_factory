require './constants'
require './string_extensions'
require './car'

class CarFactory
  include CarConstants
  include StringExtensions

  UnsupportedBrandException = Class.new(StandardError)

  def initialize(name, car_brands)
    @name = name
    @car_brands = if car_brands[:brands].is_a?(Array)
                    car_brands[:brands]
                  else
                    [car_brands[:brands]]
                  end

    unless @car_brands.all? { |brand| AVAILABLE_BRANDS.include?(brand) }
      raise UnsupportedBrandException,
            "Brand not supported: '#{to_human(car_brands[:brands])}'"
    end
  end

  def make_car(special_brand = nil)
    if special_brand.nil? && @car_brands.count > 1
      raise UnsupportedBrandException,
            'Factory does not have a brand or do not support it'
    elsif special_brand.nil?
      Car.new(@car_brands[0])
    elsif AVAILABLE_BRANDS.include?(special_brand)
      Car.new(special_brand)
    else
      raise CarFactory::UnsupportedBrandException,
            'Factory does not have a brand or do not support it'
    end
  end

  def name
    "#{@name} (produces #{to_human(@car_brands.join(', '))})"
  end
end