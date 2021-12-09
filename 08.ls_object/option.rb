# frozen_string_literal: true

require_relative './list'
require 'optparse'
require 'etc'

class Option < List
  def self.inform
    opt = OptionParser.new
    params = {}
    opt.on('-l') { |v| v }
    opt.on('-r') { |v| v }
    opt.on('-a') { |v| v }
    opt.parse!(ARGV, into: params)
    params
  end

  def calculate_block(block)
    block.each.sum { |b| File.lstat(b).blocks }
  end

  def derive(file)
    if FileTest.symlink?(file)
      link = File.readlink(file)
      "#{file}@ -> #{link}"
    else
      file
    end
  end

  def classify(file)
    { 'file' => '-', 'directory' => 'd', 'link' => 'l' }[File.ftype(file)]
  end

  def authorize(file)
    file_mode = File.lstat(file).mode.to_s(8).chars.last(3)
    file_modes = file_mode.map(&:to_i)
    file_modes.map do |m|
      {
        7 => 'rwx',
        6 => 'rw-',
        5 => 'r-x',
        4 => 'r--',
        3 => '-wx',
        2 => '-w-',
        1 => '--x'
      }[m]
    end
  end

  def print_long(files)
    puts("total #{calculate_block(files)}")
    files.each do |file|
      print classify(file)
      print authorize(file).join
      print("  #{File.lstat(file).nlink} ")
      print("#{Etc.getpwuid(File.lstat(file).uid).name} ")
      print(" #{Etc.getgrgid(File.lstat(file).gid).name}")
      printf('%6d', File.lstat(file).size)
      print File.lstat(file).mtime.strftime(' %b %e %H:%M ')
      puts derive(file)
    end
  end

  def print_reverse(lists)
    lists.reverse
  end
end

@option_object = Option.new
@list = List.new
selected = Option.inform
result = selected[:a] ? @list.list_all : @list.list
sorted_lists = selected[:r] ? @option_object.print_reverse(result) : result
selected[:l] ? @option_object.print_long(sorted_lists) : final_result = @option_object.divide(sorted_lists)
@list.display(*final_result)
