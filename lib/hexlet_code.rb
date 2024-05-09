# frozen_string_literal: true

require_relative "hexlet_code/version"

module HexletCode
  class Error < StandardError; end

  ELEMENTS = {
    default: {
      tag: "input",
      attributes: {
        type: "text",
        name: "",
        value: ""
      }
    },
    text: {
      tag: "textarea",
      attributes: {
        cols: 20,
        rows: 40
      }
    },
    checkbox: {
      tag: "input",
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

  def self.input(_name, attributes = {})
    puts @fields_data
    element = ELEMENTS[attributes.fetch(:as, :default)]
    tag = element[:tag]
    # attributes = case as
    # when :default
    #   { }
    # when

    # else

    # end
    Tag.build(tag, attributes)
  end
end
