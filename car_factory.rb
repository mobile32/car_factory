require './constants'
require './car'

class CarFactory
  include CarConstants

  def initialize(factory_name, car_brand)
    @factory_name = factory_name
    @car_brand = car_brand[:brands]

    if @car_brand == nil
      raise UnsupportedBrandException,
            "Brand not supported: #{car_brand[:brands].to_s.capitalize}"
    end
  end

  def make_car
    Car.new()
  end
end