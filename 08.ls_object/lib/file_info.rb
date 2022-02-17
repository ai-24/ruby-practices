# frozen_string_literal: true

require 'date'

class FileInfo
  def initialize(file)
    @file = file
  end

  def timestamp
    renewed_time = File.lstat(@file).mtime
    file_date = Date.parse(renewed_time.strftime(' %b %e %H:%M %Y '))
    six_month_before = Date.today << 6
    file_date > six_month_before ? renewed_time.strftime(' %b %e %H:%M ') : renewed_time.strftime(' %b %e  %Y ')
  end

  def authorize
    file_mode = File.lstat(@file).mode.to_s(8).chars.last(3)
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

  def file_type
    { 'file' => '-', 'directory' => 'd', 'link' => 'l' }[File.ftype(@file)]
  end

  def derive
    if FileTest.symlink?(@file)
      link = File.readlink(@file)
      "#{@file}@ -> #{link}"
    else
      @file
    end
  end
end
