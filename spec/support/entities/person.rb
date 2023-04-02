# frozen_string_literal: true

class Person < BaseClass
  attr_accessor :name, :driver_license

  has_one DriverLicense

  def initialize(**args)
    @name = args.fetch(:name, nil)
  end
end
