# frozen_string_literal: true

require_relative "hexlet_code/version"

module HexletCode
  class Error < StandardError; end

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

  autoload(:FormContent, "./lib/hexlet_code/form_content.rb")

  # TODO: formatting
  def self.form_for(fields_data = {}, url = "#")
    attributes = { action: url, method: "post" }
    content = FormContent.new(fields_data)
    yield(content) if block_given?
    Tag.build("form", attributes) { content if block_given? }
  end
end
