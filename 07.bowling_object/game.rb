# frozen_string_literal: true

require './frame'

class Game < Frame
  def initialize(game)
    @game = game
  end

  def split
    numbers = []
    @game.split(',').each { |n| n == 'X' ? numbers.push(n, '0') : numbers.push(n) }
    numbers
  end

  def frame
    split.each_slice(2).to_a
  end

  def final_calcilate
    frame.each_with_index.sum do |f, i|
      basic_score = Frame.new(*f).calculate
      if i > 8 || basic_score < 10
        basic_score
      elsif f[0] == 'X'
        frame_point = basic_score + Frame.new(*frame[i.next]).calculate
        if frame[i.next][0] == 'X'
          frame_point + Frame.new(*frame[i.next.next]).first_shot.score
        else
          frame_point
        end
      elsif basic_score == 10
        basic_score + Frame.new(*frame[i.next]).first_shot.score
      end
    end
  end
end

g = Game.new(ARGV[0])
puts g.final_calcilate
