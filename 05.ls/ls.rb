# frozen_string_literal: true

require 'optparse'
require 'etc'

def output(list)
  list_size = list.size / 3
  extra_list = list.size % 3
  length = extra_list != 0 ? list_size + 1 : list_size
  one = 0
  two = length
  three = two * 2
  numbers = [one, two, three]
  while numbers.size < list.size
    numbers.last(3).each do |n|
      numbers << n.next
    end
  end
  array_number = numbers.each_slice(3).to_a do |n|
    array_number << n
  end
  amount = array_number.count
  if amount > 1
    array_number[0..amount].each do |a|
      a[0..-2].each do |b|
        print list[b].ljust(30)
      end
      last = a[-1]
      puts list[last]
    end
  else
    puts list[0]
  end
end

def current_lists
  Dir.glob('*').sort.map { |list| list }
end

def option_a
  Dir.glob(['.*', '*']).sort.map { |list| list }
end

def option_r(o_r)
  if o_r.size > 1
    output o_r.reverse
  else
    output o_r
  end
end

def option_l(o_l)
  total_block = o_l.each.sum do |ol|
    mode = File.lstat(ol)
    mode.blocks
  end
  puts("total #{total_block}")
  o_l.each do |ol|
    file = File.stat(ol)
    mode = File.lstat(ol)
    type = File.ftype(ol)
    print '-' if type == 'file'
    print 'd' if type == 'directory'
    print 'l' if type == 'link'
    file_mode = mode.mode.to_s(8).chars.last(3)
    file_modes = file_mode.map(&:to_i)
    file_modes.each do |m|
      print 'rwx' if m == 7
      print 'rw-' if m == 6
      print 'r-x' if m == 5
      print 'r--' if m == 4
      print '-wx' if m == 3
      print '-w-' if m == 2
      print '--x' if m == 1
    end
    print("  #{file.nlink} ")
    file_name = Etc.getpwuid(file.uid)
    print("#{file_name.name} ")
    group_name = Etc.getgrgid(file.gid)
    print(" #{group_name.name}")
    printf('%6d', mode.size)
    print file.mtime.strftime(' %b %e %H:%M ')
    if FileTest.symlink?(ol)
      link = File.readlink(ol)
      puts("#{ol} -> #{link}")
    else
      puts ol
    end
  end
end
o = OptionParser.new
o.on('-a [OPTIONAL]') { |v| }
o.on('-l [OPTIONAL]') { |v| }
o.on('-r [OPTIONAL]') { |v| }

opts = ARGV.getopts('a', 'l', 'r')
if opts['a'] && opts['l'] && opts['r']
  option_l(option_a.reverse)
elsif opts['a'] && opts['l']
  option_l(option_a)
elsif opts['a'] && opts['r']
  option_r(option_a)
elsif opts['l'] && opts['r']
  option_l(current_lists.reverse)
elsif opts['a']
  output option_a
elsif opts['l']
  option_l(current_lists)
elsif opts['r']
  option_r(current_lists)
elsif ARGV.size.zero?
  output(current_lists)
end
o.parse!(ARGV)
