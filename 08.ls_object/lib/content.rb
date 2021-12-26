# frozen_string_literal: true

require 'date'
require_relative 'ls_command'

class Content
  def lists
    LsCommand.new.option_a? ? Dir.glob(%w[.* *]) : Dir.glob('*')
  end

  def calculate_block(block)
    block.each.sum { |b| File.lstat(b).blocks }
  end

  def stamp(file)
    renewed_time = File.lstat(file).mtime
    file_date = Date.parse(renewed_time.strftime(' %b %e %H:%M %Y '))
    six_month_before = Date.today << 6
    file_date > six_month_before ? renewed_time.strftime(' %b %e %H:%M ') : renewed_time.strftime(' %b %e  %Y ')
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

  def classify(file)
    { 'file' => '-', 'directory' => 'd', 'link' => 'l' }[File.ftype(file)]
  end

  def derive(file)
    if FileTest.symlink?(file)
      link = File.readlink(file)
      "#{file}@ -> #{link}"
    else
      file
    end
  end
end
