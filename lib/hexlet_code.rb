# frozen_string_literal: true

require_relative "hexlet_code/version"

module HexletCode
  class Error < StandardError; end

  ELEMENTS = {
    default: {
      tag: :input,
      value_position: :attribute,
      attributes: {
        type: "text"
      }
    },
    text: {
      tag: :textarea,
      value_position: :inside,
      attributes: {
        cols: 20,
        rows: 40
      }
    },
    checkbox: {
      tag: :input,
      value_position: :attribute,
      attributes: {
        type: :checkbox
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
    yield(self) if block_given?
    Tag.build("form", attributes) { @all if block_given? }
  end

  def self.input(field_name, attributes = {})
    @all ||= ""
    as = attributes.fetch(:as, :default)
    attributes.delete(:as)
    element = ELEMENTS[as]
    # Why do we need to use public_send here but not just get the value?
    value = @fields_data.public_send(field_name)
    tag = element[:tag]
    attrs = element[:attributes].merge(attributes).merge({ name: field_name.to_s })
    attrs = attrs.merge({ value: }) if element[:value_position] == :attribute

    # FIXME: how to optionaly pass block?
    @all += if element[:value_position] == :inside
        Tag.build(tag, attrs) { value }
      else
        Tag.build(tag, attrs)
      end
  end
end
