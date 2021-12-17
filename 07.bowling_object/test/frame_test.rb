# frozen_string_literal: true

require 'minitest/autorun'
require './frame'

class FrameTest < Minitest::Test
  def test_frame_sum
    first_frame = Frame.new('1', '2')
    assert_equal 3, first_frame.frame_sum

    second_frame = Frame.new('X', '0')
    assert_equal 10, second_frame.frame_sum
  end
end
