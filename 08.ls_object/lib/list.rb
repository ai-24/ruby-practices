# frozen_string_literal: true

require_relative 'ls_command'
require_relative 'content'

class List
  ROW = 3
  def sort
    content = Content.new
    LsCommand.new.option_r? ? content.lists.reverse : content.lists
  end

  def adjust(lists)
    if (lists.count % ROW).zero?
      new_lists = lists
    else
      new_lists = lists.push(nil) until (lists.count % ROW).zero?
    end
    new_lists.each_slice(new_lists.count / ROW).to_a.transpose
  end
end
