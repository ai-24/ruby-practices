# frozen_string_literal: true

require 'minitest/autorun'
require './frame'

class FrameTest < Minitest::Test
  def test_calculate
    first_frame = Frame.new("1", "2")
    assert_equal 3, first_frame.calculate

    second_frame = Frame.new("3","4", "X")
    assert_equal 17, second_frame.calculate
  end
end
