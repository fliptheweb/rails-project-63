# frozen_string_literal: true

require_relative "hexlet_code/version"

module HexletCode
  class Error < StandardError; end

  ELEMENTS = {
    default: {
      tag: "input",
      value_position: :attribute,
      attributes: {
        type: "text"
      }
    },
    text: {
      tag: "textarea",
      value_position: :inside,
      attributes: {
        cols: 20,
        rows: 40
      }
    },
    checkbox: {
      tag: "input",
      value_position: :attribute,
      attributes: {
        type: "checkbox"
      }
    }
  }

  # What is wrong here?
  # autoload(:Tag, "./lib/hexlet_code/tag.rb")

  # Tag creation
  module Tag
    def self.build(tag, attributes = {})
      attrs = attributes.map do |key, value|
        "#{key}=\"#{value}\""
      end.join(" ")
      attrs = attrs.empty? ? "" : " #{attrs}"
      "<#{tag}#{attrs}#{block_given? ? ">#{yield}</#{tag}>" : " />"}"
    end
  end

  # TODO: formatting
  def self.form_for(data = {}, url = "#")
    @fields_data = data
    attributes = { action: url, method: "post" }
    Tag.build("form", attributes) { yield(self) if block_given? }
  end

  def self.input(field_name, attributes = {})
    as = attributes.fetch(:as, :default)
    attributes.delete(:as)
    element = ELEMENTS[as]
    value = @fields_data.public_send(field_name)
    tag = element[:tag]
    attrs = element[:attributes].merge(attributes).merge({ name: field_name.to_s })
    attrs = attrs.merge({ value: }) if element[:value_position] == :attribute

    # FIXME: how to optionaly pass block?
    Tag.build(tag, attrs) do
      value if element[:value_position] == :inside
    end
  end
end
