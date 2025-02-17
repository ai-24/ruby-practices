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
end

opts.on("-y [OPTIONAL]") do |y|
  year = y.to_i
end

opts.parse!

#月 年を表示
puts "#{month}月 #{year}".center(20)

#曜日を作成
days_of_week_ja = ["日","月","火","水","木","金","土"]
puts days_of_week_ja.join(' ')

#日の作成
dates = Date.new(year,month,1)..Date.new(year,month,-1)
last_day_of_month = Date.new(year,month,-1)

add = "   "
print add*dates.first.wday

dates.each do |date|
  if date.saturday? || date == last_day_of_month 
    puts date.day.to_s.center(3)
  else
    print date.day.to_s.center(3)
  end
end
