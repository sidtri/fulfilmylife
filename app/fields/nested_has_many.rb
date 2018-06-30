require "administrate/field/has_many"
require "administrate/page/form"
require "rails"
require "administrate/engine"
require "cocoon"

module Administrate
  module Field
    class NestedHasMany < Administrate::Field::HasMany

      DEFAULT_ATTRIBUTES = %i(id _destroy).freeze

      def nested_fields
        associated_form.attributes.reject do |nested_field|
          skipped_fields.include?(nested_field.attribute)
        end
      end

      def nested_fields_for_builder(form_builder)
        return nested_fields unless form_builder.index.is_a? Integer

        nested_fields.each do |nested_field|
          next if nested_field.resource.blank?

          # inject current data into field
          resource = nested_field.resource[form_builder.index]
          nested_field.instance_variable_set(
            "@data",
            resource.send(nested_field.attribute),
          )
        end
      end

      def to_s
        data
      end

      def self.dashboard_for_resource(resource)
        "#{resource.to_s.classify}Dashboard".constantize
      end

      def self.associated_attributes(associated_resource)
        DEFAULT_ATTRIBUTES +
          dashboard_for_resource(associated_resource).new.permitted_attributes
      end

      def self.permitted_attribute(associated_resource, _options = nil)
        {
          "#{associated_resource}_attributes".to_sym =>
          associated_attributes(associated_resource),
        }
      end

      def associated_class_name
        options.fetch(:class_name, attribute.to_s.singularize.camelcase)
      end

      def association_name
        associated_class_name.underscore.pluralize
      end

      def associated_form
        Administrate::Page::Form.new(associated_dashboard, data)
      end

      private

      def skipped_fields
        Array(options[:skip])
      end
    end
  end
end