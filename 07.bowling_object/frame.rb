# frozen_string_literal: true

require_relative 'shot'
require_relative 'game'

class Frame
  ALL_PINS = 10
  attr_reader :first_shot

  def initialize(first_mark, second_mark = nil)
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
  end

  def frame_sum
    [@first_shot, @second_shot].map(&:score).sum
  end

  def strike?
    @first_shot.score == ALL_PINS
  end

  def spare?
    frame_sum == ALL_PINS
  end
end
