require './car'
require './string_transform'

class CarFactory
  UnsupportedBrandException = Class.new(StandardError)

  attr_reader :number_of_cars

  def initialize(name, brands:)
    @name = name
    @car_brands = [brands].flatten

    not_supported_brands = @car_brands.find_all do |brand|
      !Car::SUPPORTED_BRANDS.include?(brand)
    end

    unless not_supported_brands.empty?
      message = StringTransform.to_human(not_supported_brands.map(&:capitalize).join(', '))
      raise UnsupportedBrandException, "Brand not supported: '#{message}'"
    end
  end

  def make_car(special_brand = nil)
    if special_brand.nil?
      make_default_car
    else
      make_special_car(special_brand)
    end
  end

  def make_cars(args)
    if args.is_a? Numeric
      make_default_cars(args)
    elsif args.is_a? Hash
      make_special_cars(args)
    end
  end

  def name
    "#{@name} (produces #{@car_brands.map(&:capitalize).join(', ')})"
  end

  private

  attr_reader :car_brands

  def make_default_cars(number_of_cars)
    (1..number_of_cars).map { |i| make_car(car_brands[(i - 1) % car_brands.count]) }
  end

  def make_special_cars(cars_list)
    cars_list.each_with_object([]) do |(brand, quantity), cars|
      quantity.times do
        cars << make_car(brand) if Car::SUPPORTED_BRANDS.include?(brand)
      end
    end
  end

  def make_default_car
    if car_brands.count == 1
      Car.new(car_brands.first)
    else
      raise UnsupportedBrandException,
            'Factory does not have a brand or do not support it'
    end
  end

  def make_special_car(special_brand)
    if car_brands.include?(special_brand)
      Car.new(special_brand)
    else
      raise UnsupportedBrandException,
            'Factory does not have a brand or do not support it'
    end
  end
end