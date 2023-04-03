# frozen_string_literal: true

class Person < BaseClass
  attr_accessor :name, :driver_license, :addresses

  has_one DriverLicense
  has_one AuthorizedDriver
  has_many Address

  def initialize(**args)
    @name = args.fetch(:name, nil)
    @addresses = []
  end

  def self.to_h(person)
    { name: person.name, driver_license_number: person.driver_license_number.number }
  end
end
