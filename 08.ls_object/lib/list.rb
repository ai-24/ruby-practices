# frozen_string_literal: true

class List
  ROW = 3
  def list
    Dir.glob('*')
  end

  def list_all
    Dir.glob(%w[.* *])
  end

  def adjust(lists)
    if (lists.count % ROW).zero?
      new_lists = lists
    else
      new_lists = lists.push(nil) until (lists.count % ROW).zero?
    end
    new_lists.each_slice(new_lists.count / ROW).to_a.transpose
  end

  def display(*arrays)
    arrays.each do |array|
      array.each_with_index do |element, i|
        array[i] != array[-1] ? print(element.ljust(25)) : puts(element)
      end
    end
  end
end
