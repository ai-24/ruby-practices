# frozen_string_literal: true

require 'etc'

class ShortFormatter
  def display(*arrays)
    arrays.each do |array|
      array.each_with_index do |element, i|
        array[i] != array[-1] ? print(element.ljust(25)) : puts(element)
      end
    end
  end
end
