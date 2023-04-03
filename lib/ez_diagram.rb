# frozen_string_literal: false

require_relative 'ez_diagram/version'
require 'ruby-graphviz'
require 'active_support/core_ext/string'

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

    generate_entity_recursively(entity)

    $dot_file << ' }'

    GraphViz.parse_string($dot_file).output(png: "#{to_s.underscore}_diagram.png")

    $dot_file
  end

  private

  def generate_entity_recursively(entity)
    $dot_file << generate_entity(entity)

    return unless entity.class_variable_defined?('@@associations')

    entity_associations = entity.class_variable_get('@@associations')
    keys.each { |key| entity_associations[key].each { |sub_entity| create_relation(entity, sub_entity, key) } }

    keys.each { |key| entity_associations[key].each { |sub_entity| generate_entity_recursively(sub_entity) } }
  end

  def create_relation(entity, sub_entity, key)
    relation = %( "#{entity}" -> "#{sub_entity}" [arrowtail=odot, arrowhead=crow, dir=both, label="#{key}"])
    $dot_file << relation
  end

  def generate_entity(current_class)
    current_instance_methods = current_class.instance_methods(false)
                                            .map! { |variable| "#{variable.to_s.delete("@")}\\l\\" }
    current_instance_variables = current_class.new.instance_variables
                                              .map! { |variable| "#{variable.to_s.delete("@")}\\l\\" }
    current_class_methods = (current_class.methods - Object.methods)
                            .map! { |current_method| "#{current_method.to_s.delete("@")}\\l\\" }
    current_class_variables = current_class.class_variables
                                           .map! { |current_method| "#{current_method.to_s.delete("@")}\\l\\" }
    entity_to_text(current_class, current_instance_methods, current_instance_variables,
                   current_class_methods, current_class_variables)
  end

  def entity_to_text(current_class, current_instance_methods, current_instance_variables,
                     current_class_methods, current_class_variables)

    text = %(\n "#{current_class}" [shape=record, label="{#{current_class}|\\ )

    text << "\ninstance variables:\\n\\ #{current_instance_variables.sort.join(' ')}\\l\\ " if current_instance_variables.any?
    text << "\nclass variables:\\n\\ #{current_class_variables.sort.join(' ')}\\l\\ " if  current_class_variables.any?
    text << "\ninstance methods:\\n\\ #{current_instance_methods.sort.join(' ')}\\l\\ " if current_instance_methods.any?
    text << "\nclass methods:\\n\\ #{current_class_methods.sort.join(' ')}\\l\\ " if current_class_methods.any?

    text << %(}"])
  end

  def keys
    %i[has_one has_many]
  end

  def define_necessary_keys(associations)
    keys.each { |key| associations[key] = [] if associations.fetch(key, []).empty? }
  end
end
