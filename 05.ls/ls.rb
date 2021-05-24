# frozen_string_literal: true

require 'optparse'
require 'etc'

class Printer
  def self.sorting(list)
    list_size = list.size / 3
    extra_list_size = list.size % 3
    length = extra_list_size != 0 ? list_size + 1 : list_size
    numbers = [0, length, length * 2]
    numbers.last(3).each { |n| numbers << n.next } while numbers.size < list.size
    numbers.each_slice(3).map { |n| n }
  end

  def self.put(list)
    array_number = Printer.sorting(list)
    amount = array_number.count
    if amount > 1
      array_number[0..amount].each do |a|
        a[0..-2].each do |b|
          print list[b].ljust(30)
        end
        puts list[a[-1]]
      end
    else
      puts list[0]
    end
  end
end

def current_lists
  Dir.glob('*').sort.map { |l| l }
end

def current_lists_all
  Dir.glob(['.*', '*']).sort.map { |list| list }
end

class OptL
  def self.l_block(o_l)
    o_l.each.sum do |ol|
      mode = File.lstat(ol)
      mode.blocks
    end
  end

  def self.symlink(o_l)
    if FileTest.symlink?(o_l)
      link = File.readlink(o_l)
      puts("#{o_l} -> #{link}")
    else
      puts o_l
    end
  end

  def self.ftype(o_l)
    type = File.ftype(o_l)
    print '-' if type == 'file'
    print 'd' if type == 'directory'
    print 'l' if type == 'link'
  end

  def self.lstat(o_l)
    File.lstat(o_l)
  end

  def self.mode(o_l)
    file_mode = OptL.lstat(o_l).mode.to_s(8).chars.last(3)
    file_modes = file_mode.map(&:to_i)
    file_modes.each do |m|
      case m
      when 7
        print 'rwx'
      when 6
        print 'rw-'
      when 5
        print 'r-x'
      when 4
        print 'r--'
      when 3
        print '-wx'
      when 2
        print '-w-'
      when 1
        print '--x'
      end
    end
  end

  def self.option_l(o_l)
    puts("total #{OptL.l_block(o_l)}")
    o_l.each do |ol|
      OptL.ftype(ol)
      OptL.mode(ol)
      print("  #{OptL.lstat(ol).nlink} ")
      file_name = Etc.getpwuid(OptL.lstat(ol).uid)
      print("#{file_name.name} ")
      group_name = Etc.getgrgid(OptL.lstat(ol).gid)
      print(" #{group_name.name}")
      printf('%6d', OptL.lstat(ol).size)
      print OptL.lstat(ol).mtime.strftime(' %b %e %H:%M ')
      OptL.symlink(ol)
    end
  end
end

@option = {}
OptionParser.new do |opt|
  opt.on('-a') { |v| @option[:a] = v }
  opt.on('-r') { |v| @option[:r] = v }
  opt.on('-l') { |v| @option[:l] = v }
  opt.parse!(ARGV)
end

fetched_files = @option[:a] ? current_lists_all : current_lists
fetched_files_sort = @option[:r] ? fetched_files.reverse : fetched_files

if @option[:l] && @option[:r]
  OptL.option_l(fetched_files_sort)
elsif @option[:l]
  OptL.option_l(fetched_files)
else
  Printer.put fetched_files_sort
end
