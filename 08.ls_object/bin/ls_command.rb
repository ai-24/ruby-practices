# frozen_string_literal: true

require 'optparse'
require_relative '../lib/file_list_generator'
require_relative '../lib/long_formatter'
require_relative '../lib/short_formatter'
require_relative '../lib/file_info'

class LsCommand
  def save
    opt = OptionParser.new
    params = {}
    opt.on('-a') { |v| params[:a] = v }
    opt.on('-r') { |v| params[:r] = v }
    opt.on('-l') { |v| params[:l] = v }
    opt.parse(ARGV)
    params
  end

  def option_a?
    save[:a]
  end

  def option_r?
    save[:r]
  end

  def option_l?
    save[:l]
  end

  def pick
    list = option_a? ? FileInfo.new.list_all : FileInfo.new.list
    sort = option_r? ? list.reverse : list
    option_l? ? LongFormatter.new.print_long(sort) : ShortFormatter.new.display(*FileListGenerator.new(sort).adjust)
  end
end

LsCommand.new.pick
