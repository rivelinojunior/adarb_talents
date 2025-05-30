# frozen_string_literal: true

module Profiles
  class LinksSchemaValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      return if value.blank?
      return if value.is_a?(Array) && value.all? { |link| schema_valid?(link) }

      record.errors.add(attribute, "is invalid")
    end

    private

    def schema_valid?(link)
      link.is_a?(Hash) && link["name"].present? && link["link"].present?
    end
  end
end
