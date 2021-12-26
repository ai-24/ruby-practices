# frozen_string_literal: true

require 'etc'
require_relative 'ls_command'
require_relative 'content'
require_relative 'list'

class Output
  def print_long(files)
    content = Content.new
    puts("total #{content.calculate_block(files)}")
    files.each do |file|
      print content.classify(file)
      print content.authorize(file).join
      print("  #{File.lstat(file).nlink.to_s.rjust(3)} ")
      print("#{Etc.getpwuid(File.lstat(file).uid).name} ")
      print(" #{Etc.getgrgid(File.lstat(file).gid).name}")
      printf('%6d', File.lstat(file).size)
      print content.stamp(file)
      puts content.derive(file)
    end
  end

  def display(*arrays)
    arrays.each do |array|
      array.each_with_index do |element, i|
        array[i] != array[-1] ? print(element.ljust(25)) : puts(element)
      end
    end
  end

  def export
    files = List.new
    LsCommand.new.option_l? ? print_long(files.sort) : display(*files.adjust(files.sort))
  end
end
