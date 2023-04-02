# frozen_string_literal: true

RSpec.describe EzDiagram do
  it 'has a version number' do
    expect(EzDiagram::VERSION).not_to be nil
  end

  context '.has_one' do
    let(:person) { Person.new(name: 'McLovin') }
    let!(:driver_license) { DriverLicense.new(number: '01-47-87441', person:) }

    it 'should associate using has_one in the class Person with DriverLicense' do
      Person.new

      expect(Person.class_variable_get('@@associations')).to eq({ has_one: [DriverLicense],
                                                                  has_many: [],
                                                                  belongs_to: [] })
    end
  end
end
