#!/usr/bin/env ruby

require "date"
require "optparse/date"

#今日の日付を取得
today = Date.today
month = today.month
year = today.year

#コマンドオプションの作成
opts = OptionParser.new
opts.on("-m [OPTIONAL]") do |m|
  month = m.to_i
  dates = (Date.new(year,month,1)..Date.new(year,month,-1))
  last_day_of_month = Date.new(year,month,-1)
end

opts.on("-y [OPTIONAL]") do |y|
  year = y.to_i
  dates = (Date.new(year,month,1)..Date.new(year,month,-1))
  last_day_of_month = Date.new(year,month,-1)
end

opts.parse!

#月 年を表示
puts "#{month}月 #{year}".center(20)

#曜日を作成
days_of_week = (0..6).to_a
days_of_week_ja = ["日 ","月 ","火 ","水 ","木 ","金 ","土"]

days_of_week.each do |day_of_week|
  if day_of_week == 6
    puts days_of_week_ja[day_of_week]
  end
  break if day_of_week == 6
    print days_of_week_ja[day_of_week]
end

#日の作成
dates = Date.new(year,month,1)..Date.new(year,month,-1)
last_day_of_month = Date.new(year,month,-1)
dates.to_a

dates.each do |date|
  add = "   "
  if date.day==1 && date.saturday?
    each_day = add*date.wday
    puts each_day + date.day.to_s.center(3)
  elsif date.day==1 
    each_day = add*date.wday
    print each_day + date.day.to_s.center(3)
  elsif date.saturday? || date == last_day_of_month 
    puts date.day.to_s.center(3)
  else
    print date.day.to_s.center(3)
  end
end
