# frozen_string_literal: true

require './frame'

class Game < Frame
  attr_reader :game

  def initialize(game)
    @game = game
  end

  def split
    numbers = []
    @game.split(',').each { |n| n == "X" ? numbers.push(n,"0") : numbers.push(n) }
    numbers
  end

  def frame
    split.each_slice(2).to_a
  end

  def total_score
    frame.each_with_index.sum do |f, i|
      number = Frame.new(*f)
      basic_score = number.calculate
      # extra_frame = frame[i.next]
      if i > 8 || basic_score < 10
        basic_score
      elsif f[0] == "X"
        extra_point = Frame.new(*frame[i.next])
        frame_point = basic_score + extra_point.calculate
        if frame[i.next][0] == "X"
          double_extra_frame = Frame.new(*frame[i.next.next])
          frame_point + double_extra_frame.first_shot.score
        else
          frame_point
        end
      elsif basic_score == 10
        extra_point = Frame.new(*frame[i.next])
        basic_score + extra_point.first_shot.score
      end
    end
  end
end

# g = Game.new(ARGV[0])
# puts g.total_score
