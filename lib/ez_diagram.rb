# frozen_string_literal: false

require_relative 'ez_diagram/version'
require 'ruby-graphviz'

module EzDiagram
  class Error < StandardError; end

  def has_one(attached_class)
    if class_variable_defined?('@@associations')
      associations = class_variable_get('@@associations')

      define_necessary_keys(associations)
      associations[:has_one] << attached_class unless associations[:has_one].include? attached_class

      class_variable_set('@@associations', associations)
    else
      associations_tamplate = { has_one: [attached_class], has_many: [], belongs_to: [] }
      class_variable_set('@@associations', associations_tamplate)
    end
  end

  def has_many(attached_class)
    if class_variable_defined?('@@associations')
      associations = class_variable_get('@@associations')

      define_necessary_keys(associations)
      associations[:has_many] << attached_class unless associations[:has_many].include? attached_class

      class_variable_set('@@associations', associations)
    else
      associations_tamplate = { has_one: [], has_many: [attached_class], belongs_to: [] }
      class_variable_set('@@associations', associations_tamplate)
    end
  end

  def generate_dot_file
    $dot_file = 'digraph models_diagram { graph[overlap=false, splines=true] '

    entity = self

    return unless entity.class_variable_defined?('@@associations')

    dig_entity_recursively(entity)

    $dot_file << ' }'

    # `dot -Tpng spec/fixtures/person_class_diagram.dot > output.png`
    GraphViz.parse_string($dot_file).output(png: "#{self}.png")

    $dot_file
  end

  private

  def dig_entity_recursively(entity)
    $dot_file << generate_entity(entity)

    return unless entity.class_variable_defined?('@@associations')

    # gerar ligação as filhas se tiver
    entity_associations = entity.class_variable_get('@@associations')
    keys.each { |key| entity_associations[key].each { |sub_entity| create_relation(entity, sub_entity, key) } }

    # entity.class_variable_get('@@associations')
    keys.each { |key| entity_associations[key].each { |sub_entity| dig_entity_recursively(sub_entity) } }
  end

  def create_relation(entity, sub_entity, key)
    relation = %( "#{entity}" -> "#{sub_entity}" [arrowtail=odot, arrowhead=crow, dir=both, label="#{key}"])
    $dot_file << relation
  end

  def generate_entity(current_class)
    current_instance_methods = current_class.instance_methods(false)
                                            .map! { |variable| "#{variable.to_s.delete("@")}\\l\\" }
                                            .sort.join(' ')
    current_instance_variables = current_class.new.instance_variables
                                              .map! { |variable| "#{variable.to_s.delete("@")}\\l\\" }
                                              .sort.join(' ')
    current_class_methods = (current_class.methods - Object.methods)
                            .map! { |current_method| "#{current_method.to_s.delete("@")}\\l\\" }
                            .sort.join(' ')
    current_class_variables = current_class.class_variables
                                           .map! { |current_method| "#{current_method.to_s.delete("@")}\\l\\" }
                                           .sort.join(' ')
    entity_to_text(current_class, current_instance_methods, current_instance_variables,
                   current_class_methods, current_class_variables)
  end

  def entity_to_text(current_class, current_instance_methods, current_instance_variables,
                     current_class_methods, current_class_variables)
    %(
      "#{current_class}" [shape=record, label="{#{current_class}|\\
        instance variables:\\n\\ #{current_instance_variables}
        class variables:\\n\\ #{current_class_variables}
        instance methods:\\n\\ #{current_instance_methods}
        class methods:\\n\\ #{current_class_methods}

      }"]
    )
  end

  def keys
    %i[has_one has_many]
  end

  def define_necessary_keys(associations)
    keys.each { |key| associations[key] = [] if associations.fetch(key, []).empty? }
  end
end
