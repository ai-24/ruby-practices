# frozen_string_literal: true

require 'etc'
require_relative 'file_info'

class LongFormatter
  def print_long(files)
    file_info = FileInfo.new
    puts("total #{file_info.calculate_block(files)}")
    files.each do |file|
      print file_info.classify(file)
      print file_info.authorize(file).join
      print("  #{File.lstat(file).nlink.to_s.rjust(3)} ")
      print("#{Etc.getpwuid(File.lstat(file).uid).name} ")
      print(" #{Etc.getgrgid(File.lstat(file).gid).name}")
      printf('%6d', File.lstat(file).size)
      print file_info.stamp(file)
      puts file_info.derive(file)
    end
  end
end
