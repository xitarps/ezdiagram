# frozen_string_literal: true

class Address
  attr_accessor :street, :number
  attr_reader :person

  def initialize(**args)
    @number = args.fetch(:number, nil)
    @street = args.fetch(:street, nil)
    @person = args[:person]
    @person.addresses << self
  end
end
