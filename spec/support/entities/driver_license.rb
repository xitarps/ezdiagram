# frozen_string_literal: true

class DriverLicense < BaseClass
  attr_accessor :number

  has_one ::AuthorizedDriver

  def initialize(**args)
    @number = args.fetch(:number, nil)
    @person = args[:person]
    @person&.driver_license = self if @person
  end
end
