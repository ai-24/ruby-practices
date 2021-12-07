# frozen_string_literal: true

require './shot'

class Frame < Shot
  attr_reader :first_shot, :second_shot

  def initialize(first_mark, second_mark = nil)
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
  end

  def calculate
    [@first_shot, @second_shot].map(&:score).sum
  end
end
