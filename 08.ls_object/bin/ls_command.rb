# frozen_string_literal: true

require 'optparse'
require_relative '../lib/file_list_generator'
require_relative '../lib/long_formatter'
require_relative '../lib/short_formatter'

class LsCommand
  def pick
    list = option_a? ? FileListGenerator.list_all : FileListGenerator.list
    sort = option_r? ? list.reverse : list
    option_l? ? LongFormatter.new(sort).print_long : ShortFormatter.new(sort).display
  end

  private

  def parse_options(options)
    opt = OptionParser.new
    @parsed_options ||= {}
    opt.on('-a') { |v| @parsed_options[:a] = v }
    opt.on('-r') { |v| @parsed_options[:r] = v }
    opt.on('-l') { |v| @parsed_options[:l] = v }
    opt.parse(options)
    @parsed_options
  end

  def options
    ARGV
  end

  def option_a?
    parse_options(options)[:a]
  end

  def option_r?
    parse_options(options)[:r]
  end

  def option_l?
    parse_options(options)[:l]
  end
end

LsCommand.new.pick
