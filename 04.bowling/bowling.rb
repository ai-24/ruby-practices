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

frames = []
shots.each_slice(2) do |s|
  frames << s
end

point = 0
frames.each_with_index do |frame, i|
  if frame[0] == 10
    break if i > 9

    i += 1
    extra_point = frames[i]
    break if extra_point.nil?

    point += frame.sum + extra_point.sum
    if extra_point[0] == 10
      i += 1
      double_extra_point = frames[i]
      break if double_extra_point.nil?

      point += double_extra_point[0]
    end
  elsif frame.sum == 10 && frame != frames[-1]
    i += 1
    extra_point = frames[i]
    point += frame.sum + extra_point[0]
  else
    break if frame == frames[-1] && frames.size > 10

    point += frame.sum
  end
end

puts point
