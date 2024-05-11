# frozen_string_literal: true

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

  def initialize(fields_data)
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
    attrs = attrs.merge({ value: }) if element[:value_position] == :attribute

    # FIXME: how to optionaly pass block to function?
    @all += if element[:value_position] == :inside
              HexletCode::Tag.build(tag, attrs) { value }
            else
              HexletCode::Tag.build(tag, attrs)
            end
  end

  def to_s
    @all
  end
end
