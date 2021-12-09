# frozen_string_literal: true

class List
  def list
    Dir.glob('*')
  end

  def list_all
    Dir.glob(%w[.* *])
  end

  def divide(lists)
    if (lists.count % 3).zero?
      new_lists = lists
    else
      new_lists = lists.push(nil) until (lists.count % 3).zero?
    end
    new_lists.each_slice(new_lists.count / 3).to_a.transpose
  end

  def display(*arrays)
    arrays.each do |array|
      array.each_with_index do |element, i|
        array[i] != array[-1] ? print(element.ljust(25)) : puts(element)
      end
    end
  end
end
