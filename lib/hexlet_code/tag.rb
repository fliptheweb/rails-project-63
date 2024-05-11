# frozen_string_literal: true

# Tag creation
module Tag
  def self.build(tag, attributes = {})
    attrs = attributes.map do |key, value|
      "#{key}=\"#{value}\""
    end.join(' ')
    attrs = attrs.empty? ? '' : " #{attrs}"
    "<#{tag}#{attrs}#{block_given? ? ">#{yield}</#{tag}>" : ' />'}"
  end
end
