# frozen_string_literal: true

require 'minitest/autorun'
require './shot'

class ShotTest < Minitest::Test
  def test_score
    first_shot = Shot.new('1')
    assert_equal 1, first_shot.score

    second_shot = Shot.new('X')
    assert_equal 10, second_shot.score
  end
end
