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

opts.on("-y {OPTIONAL]") do |y|
  year = y.to_i
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
  each_day = date.day.to_s.center(3)
  
  case
  when date.day == 1.to_i&& date.monday?
    print add + each_day
  when date.day == 1.to_i&&date.tuesday?
    print add*2 + each_day
  when date.day == 1.to_i&&date.wednesday?
    print add*3 + each_day
  when date.day == 1.to_i&&date.thursday?
    print add*4 + each_day
  when date.day == 1.to_i&&date.friday?
    print add*5 + each_day
  when date.day == 1.to_i&&date.saturday?
    puts add*6 + each_day
  when date.day == 1.to_i&&date.sunday?
    print each_day
  when date.saturday? || date == last_day_of_month 
    puts each_day = date.day.to_s.center(3)
  next if date.saturday? || date == last_day_of_month
  else
    print each_day = date.day.to_s.center(3)
  end
end

