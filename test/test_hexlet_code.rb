# frozen_string_literal: true

require "test_helper"

User = Struct.new(:name, :job, :gender, keyword_init: true)

class TestHexletCode < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_that_it_generates_tag_with_content
    element = HexletCode::Tag.build("div", src: "http://image.com", width: 120) { "content" }
    assert {
      element == "<div src=\"http://image.com\" width=\"120\">content</div>"
    }
  end

  def test_that_it_generates_tag_without_content
    element = HexletCode::Tag.build("br")
    assert {
      element == "<br />"
    }
  end

  def test_that_it_generates_form
    element = HexletCode.form_for
    assert {
      element == "<form action=\"#\" method=\"post\"></form>"
    }
  end

  def test_that_it_generates_form_with_url
    element = HexletCode.form_for(nil, "http://google.com")
    assert {
      element == "<form action=\"http://google.com\" method=\"post\"></form>"
    }
  end

  def test_that_it_generates_form_with_options
    element = HexletCode.form_for(nil, url: "/profile", method: :get, class: "hexlet-form")

    assert {
      element == "<form action=\"/profile\" method=\"get\" class=\"hexlet-form\"></form>"
    }
  end

  def test_that_it_generates_form_with_inputs
    user = User.new name: "rob", job: "hexlet", gender: "m"
    rendered = "<form action=\"#\" method=\"post\"><label for=\"name\">Name</label><input type=\"text\" name=\"name\" value=\"rob\" /><label for=\"job\">Job</label><textarea cols=\"20\" rows=\"40\" name=\"job\">hexlet</textarea></form>"

    element = HexletCode.form_for user do |f|
      f.input :name
      f.input :job, as: :text
    end

    assert {
      element == rendered
    }
  end

  def test_that_it_generates_form_with_submit
    rendered = "<form action=\"#\" method=\"post\"><input type=\"submit\" value=\"Save\" /></form>"
    element = HexletCode.form_for({}) do |f|
      f.submit
    end

    assert {
      element == rendered
    }
  end
end
