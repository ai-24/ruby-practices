# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = shots.each_slice(2).to_a do |s|
  frames << s
end


point = frames.each_with_index.sum do |frame, i|
  #require 'byebug';byebug

  break if frame == frames[-1]

  if frame[0] == 10
    next 0 if i > 9

    extra_point = frames[i.next]
    next 0 if extra_point.nil?

    frame_point = frame.sum + extra_point.sum
    if extra_point[0] == 10
      double_extra_point = frames[i.next.next]
      next 0 if double_extra_point.nil?

      frame_point + double_extra_point[0]
    end
  elsif frame.sum == 10
    extra_point = frames[i.next]
    frame.sum + extra_point[0]
  else
    next 0 if frames.size > 10

    frame.sum
  end
end

puts point
