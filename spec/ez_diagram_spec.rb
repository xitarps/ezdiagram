# frozen_string_literal: true

RSpec.describe EzDiagram do
  before(:example) { Person.class_variable_set('@@associations', {}) }

  it 'has a version number' do
    expect(EzDiagram::VERSION).not_to be nil
  end

  context '.has_one' do
    let!(:person) { Person.new(name: 'McLovin') }
    let!(:driver_license) { DriverLicense.new(number: '01-47-87441', person:) }

    it 'should associate using has_one in the class Person with DriverLicense' do
      Person.has_one DriverLicense
      expect(Person.class_variable_get('@@associations')).to eq({ has_one: [DriverLicense],
                                                                  has_many: []
                                                                })
    end
  end

  context '.has_many' do
    let!(:person) { Person.new(name: 'McLovin') }
    let!(:address_sp) { Address.new(number: '1618', street: 'Beco diagonal', person:) }
    let!(:address_rj) { Address.new(number: '2718', street: 'Elm', person:) }

    it 'should associate using has_one in the class Person with DriverLicense' do
      Person.has_many Address
      expect(Person.class_variable_get('@@associations')).to eq({ has_one: [],
                                                                  has_many: [Address]
                                                                })
    end
  end

  context '.generate_dot_file' do
    it 'should return proper dot file' do
      Person.has_one DriverLicense
      Person.has_many Address
      Person.generate_dot_file
    end
  end
end
