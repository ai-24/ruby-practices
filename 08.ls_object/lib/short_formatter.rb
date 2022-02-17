# frozen_string_literal: true

class ShortFormatter
  ROW = 3

  def initialize(files)
    @files = files
  end

  def display
    adjust.each do |array|
      array.each_with_index do |element, i|
        array[i] != array[-1] ? print(element.ljust(25)) : puts(element)
      end
    end
  end

  private

  def adjust
    if (@files.count % ROW).zero?
      new_lists = @files
    else
      new_lists = @files.push(nil) until (@files.count % ROW).zero?
    end
    new_lists.each_slice(new_lists.count / ROW).to_a.transpose
  end
end
