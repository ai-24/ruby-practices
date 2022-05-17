# frozen_string_literal: true

require_relative 'frame'
require_relative 'shot'

class Game
  ALL_PINS = 10
  NINE_FRAME = 8
  def initialize(game)
    @game = game
  end

  def final_calculate
    frames.each_with_index.sum do |f, i|
      basic_score = f.frame_sum
      next_frame = frames[i.next]
      if i > NINE_FRAME || basic_score < ALL_PINS
        basic_score
      elsif f.strike?
        frame_point = basic_score + next_frame.frame_sum
        next_frame.strike? ? frame_point + frames[i.next.next].first_shot.score : frame_point
      elsif f.spare?
        basic_score + next_frame.first_shot.score
      end
    end
  end

  private

  def split
    numbers = []
    @game.split(',').each { |n| n == 'X' ? numbers.push(n, '0') : numbers.push(n) }
    numbers
  end

  def frames
    frames = split.each_slice(2).to_a
    frames.map { |frame| Frame.new(*frame) }
  end
end
