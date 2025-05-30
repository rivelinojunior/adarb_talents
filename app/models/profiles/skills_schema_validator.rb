# frozen_string_literal: true

module Profiles
  class SkillsSchemaValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      return if value.blank?
      return if value.is_a?(Array) && value.all? { |skill| schema_valid?(skill) }

      record.errors.add(attribute, "is invalid")
    end

    private

    def schema_valid?(skill)
      skill.is_a?(Hash) && 
        skill["name"].present? && 
        skill["experience_in_year"].is_a?(Integer) &&
        skill["experience_in_year"] >= 0
    end
  end
end
