# frozen_string_literal: true

require_relative "hexlet_code/version"

module HexletCode
  class Error < StandardError; end

  module Tag
    def self.build(tag, *attributes)
      attrs = attributes.map do |attr|
        attr.map { |key, value| "#{key}=\"#{value}\"" }.join(' ')
      end
      attrs = attrs.empty? ? "" : " #{attrs.join(".")}"
      "<#{tag}#{attrs}#{block_given? ? ">#{yield}</#{tag}>" : " />"}"
    end
  end
end
