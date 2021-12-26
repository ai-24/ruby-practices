# frozen_string_literal: true

require 'optparse'

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
end
