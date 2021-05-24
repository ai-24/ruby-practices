# frozen_string_literal: true

require 'optparse'

opt = OptionParser.new
opts = ARGV.getopts('l')
opt.on('-l [OPTIONAL]') { |l| }

def name(arg)
  puts(" #{arg}")
end

def read(arg)
  File.read(arg)
end

def lines(arg)
  n_lines = arg.count("\n")
  /[^\n]\z/.match?(arg) ? n_lines + 1 : n_lines
end

def words(arg)
  n_words = arg.scan(/[\s\n]{1,}/)
  count_words = n_words.size
  /[^\s\n]\z/.match?(arg) ? count_words + 1 : count_words
end

def lines_total
  ARGV.sum do |arg|
    argv = read(arg)
    lines(argv)
  end
end

if opts['l']
  ARGV.each do |arg|
    read = read(arg)
    printf('%8d', lines(read))
    name(arg)
  end
  if ARGV.size > 1
    printf('%8d', lines_total)
    puts ' total'
  end
elsif ARGV.size.positive?
  ARGV.each do |arg|
    read = read(arg)
    printf('%8d', lines(read))
    printf('%8d', words(read))
    printf('%8d', read.bytesize)
    name(arg)
  end
  if ARGV.size > 1
    printf('%8d', lines_total)
    words_total = ARGV.sum do |arg|
      argv = read(arg)
      words(argv)
    end
    printf('%8d', words_total)
    bytesize_total = ARGV.sum do |arg|
      argv = read(arg)
      argv.bytesize
    end
    printf('%8d', bytesize_total)
    puts ' total'
  end
elsif ARGV.empty?
  pipe = $stdin.read
  printf('%8d', lines(pipe))
  printf('%8d', words(pipe))
  puts pipe.bytesize.to_s.rjust(8)
end

opt.parse!
