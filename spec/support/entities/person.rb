# frozen_string_literal: true

class Person < BaseClass
  attr_accessor :name, :driver_license, :addresses

  has_one DriverLicense
  has_many Address

  def initialize(**args)
    @name = args.fetch(:name, nil)
    @addresses = []
  end
end
