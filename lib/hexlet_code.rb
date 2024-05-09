# frozen_string_literal: true

require_relative "hexlet_code/version"

module HexletCode
  class Error < StandardError; end

  # What is wrong here?
  # autoload(:Tag, "./lib/hexlet_code/tag.rb")

  # Tag creation
  module Tag
    def self.build(tag, *attributes)
      attrs = attributes.map do |attr|
        attr.map { |key, value| "#{key}=\"#{value}\"" }.join(" ")
      end
      attrs = attrs.empty? ? "" : " #{attrs.join(".")}"
      "<#{tag}#{attrs}#{block_given? ? ">#{yield}</#{tag}>" : " />"}"
    end
  end

  def self.form_for(_data = {}, url = "#")
    attrs = { action: url, method: "post" }
    Tag.build("form", attrs) { "" }
  end
end
