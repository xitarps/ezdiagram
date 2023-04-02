# frozen_string_literal: true

require_relative 'ez_diagram/version'

module EzDiagram
  class Error < StandardError; end

  def has_one(attached_class)
    if class_variable_defined?('@@associations')
      associations = class_variable_get('@@associations')
      associations[:has_one] << attached_class unless associations[:has_one].include? attached_class

      class_variable_set('@@associations', associations)
    else
      associations_tamplate = { has_one: [attached_class], has_many: [], belongs_to: [] }
      class_variable_set('@@associations', associations_tamplate)
    end
  end
end
