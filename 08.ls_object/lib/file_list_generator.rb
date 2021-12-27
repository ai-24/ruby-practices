# frozen_string_literal: true

require 'etc'
require_relative 'file_info'

class FileListGenerator
  ROW = 3

  def initialize(list)
    @list = list
  end

  def adjust
    if (@list.count % ROW).zero?
      new_lists = @list
    else
      new_lists = @list.push(nil) until (@list.count % ROW).zero?
    end
    new_lists.each_slice(new_lists.count / ROW).to_a.transpose
  end
end
