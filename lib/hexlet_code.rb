# frozen_string_literal: true

require_relative 'hexlet_code/version'

# Module for build forms
module HexletCode
  class Error < StandardError; end

  autoload :Tag, 'hexlet_code/tag.rb'
  autoload :FormContent, 'hexlet_code/form_content.rb'

  # TODO: formatting
  def self.form_for(fields_data = {}, attributes = {})
    url = (attributes.is_a?(Hash) ? attributes.fetch(:url, '#') : attributes)
    attrs = { action: url, method: 'post' }
    attrs.merge!(attributes) if attributes.is_a?(Hash)
    attrs.delete(:url)
    content = FormContent.new(fields_data, Tag)
    yield(content) if block_given?
    Tag.build('form', attrs) { content if block_given? }
  end
end
