# frozen_string_literal: true

class DriverLicense
  attr_accessor :number

  def initialize(**args)
    @number = args.fetch(:number, nil)
    @person = args[:person]
    @person.driver_license = self
  end
end
