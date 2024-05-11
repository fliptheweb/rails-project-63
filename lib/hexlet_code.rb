# frozen_string_literal: true

require_relative "hexlet_code/version"

module HexletCode
  class Error < StandardError; end

  # How to properly load the module?
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

  # autoload(:FormContent, "./lib/hexlet_code/form_content.rb")
  # Form Content provides methods to build content of the form
  class FormContent
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

    def initialize(fields_data, formatter)
      @formatter = formatter
      @fields_data = fields_data
      @all = ""
    end

    def input(field_name, attributes = {})
      as = attributes.fetch(:as, :default)
      attributes.delete(:as)
      element = ELEMENTS[as]
      # Why do we need to use public_send here but not just get the value?
      value = @fields_data.public_send(field_name)
      tag = element[:tag]
      attrs = element[:attributes].merge(attributes).merge({ name: field_name.to_s })

      @all += @formatter.build("label", { for: field_name }) { field_name.capitalize }

      # FIXME: how to optionaly pass block to function?
      @all += if element[:value_position] == :inside
                @formatter.build(tag, attrs) { value }
              elsif element[:value_position] == :attribute
                attrs = attrs.merge({ value: })
                @formatter.build(tag, attrs)
              end
    end

    def submit(text = "Save")
      @all += @formatter.build(:input, { type: "submit", value: text })
    end

    def to_s
      @all
    end
  end

  # TODO: formatting
  def self.form_for(fields_data = {}, url = "#")
    attributes = { action: url, method: "post" }
    content = FormContent.new(fields_data, Tag)
    yield(content) if block_given?
    Tag.build("form", attributes) { content if block_given? }
  end
end
