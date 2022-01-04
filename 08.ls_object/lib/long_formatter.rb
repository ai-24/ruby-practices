# frozen_string_literal: true

require 'etc'
require_relative 'file_info'

class LongFormatter
  def initialize(files)
    @files = files
  end

  def print_long
    puts("total #{@files.each.sum { |b| File.lstat(b).blocks }}")
    @files.each do |file|
      file_info = FileInfo.new(file)
      print file_info.file_type
      print file_info.authorize.join
      print("  #{File.lstat(file).nlink.to_s.rjust(3)} ")
      print("#{Etc.getpwuid(File.lstat(file).uid).name} ")
      print(" #{Etc.getgrgid(File.lstat(file).gid).name}")
      printf('%6d', File.lstat(file).size)
      print file_info.timestamp
      puts file_info.derive
    end
  end
end
