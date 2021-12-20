# frozen_string_literal: true

require './frame'
require './shot'

class Game
  def initialize(game)
    @game = game
  end

  def final_calculate
    frame.each_with_index.sum do |f, i|
      basic_score = f.frame_sum
      next_frame = frame[i.next]
      if i > 8 || basic_score < 10
        basic_score
      elsif f.first_shot.score == 10
        frame_point = basic_score + next_frame.frame_sum
        triple_point?(next_frame: next_frame, extra_point: frame_point, another_frame: frame[i.next.next])
      elsif basic_score == 10
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

  def frame
    frames = split.each_slice(2).to_a
    frames.map { |frame| Frame.new(*frame) }
  end

  def triple_point?(next_frame:, extra_point:, another_frame:)
    if next_frame.first_shot.score == 10
      extra_point + another_frame.first_shot.score
    else
      extra_point
    end
  end
end

g = Game.new(ARGV[0])
puts g.final_calculate
