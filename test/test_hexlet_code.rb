# frozen_string_literal: true

require "test_helper"

class TestHexletCode < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_that_it_generates_tag_with_content
    element = ::HexletCode::Tag.build("div", src: "http://image.com", width: 120) { "content" }
    assert {
      element == "<div src=\"http://image.com\" width=\"120\">content</div>"
    }
  end

  def test_that_it_generates_tag_without_content
    element = ::HexletCode::Tag.build("br")
    assert {
      element == "<br />"
    }
  end
end
