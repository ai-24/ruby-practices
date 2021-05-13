#!/usr/bin/env ruby
require 'optparse'
require 'etc'

# カレントディレクトリ内のファイル、ディレクトリ
current_lists = Dir.glob("*").sort.map { |list| list }

#オプション
opts = OptionParser.new
opts.on("-a [OPTIONAL]") do |a|
  Dir.glob(".*").sort.each do |list|
    puts list
  end
  puts current_lists
end

opts.on("-r [OPTIONAL]") do |r|
  puts current_lists.reverse
end

  opts.on("-l [OPTIONAL]") do |l|
  total_block = current_lists.each.sum do |current_l|
    mode = File.lstat(current_l)
    mode.blocks
  end
  puts ("total #{total_block}")
  current_lists.each do |current_list|
    file = File.stat(current_list)
    mode = File.lstat(current_list)
    type = File.ftype(current_list)
    print "-" if type == "file"
    print "d" if type == "directory"
    print "l" if type == "link"

    file_mode = mode.mode.to_s(8).chars.last(3)
    file_modes = file_mode.map {|fm| fm.to_i }
    file_modes.each do |m|
      print "rwx" if m == 7
      print "rw-" if m == 6
      print "r-x" if m == 5
      print "r--" if m == 4
      print "-wx" if m == 3
      print "-w-" if m == 2
      print "--x" if m == 1
      end
    print ("  #{file.nlink} ")
    file_id = file.uid
    file_name = Etc.getpwuid(file_id)
    print ("#{file_name.name} ")
    group_id = file.gid
    group_name = Etc.getgrgid(group_id)
    print (" #{group_name.name}")
    printf("%6d",mode.size)
    print file.mtime.strftime(" %b %e %H:%M ")
    if FileTest.symlink?(current_list)
      link = File.readlink(current_list)
      puts ("#{current_list} -> #{link}")
    else
      puts current_list
    end
  end

end
if ARGV.size == 0
  puts current_lists
end

opts.parse!
