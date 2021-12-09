# frozen_string_literal: true

require 'minitest/autorun'
require './list'

class ListTest < Minitest::Test
  def setup
    @lists = List.new
  end

  def test_list
    assert_equal %w[empty.rb fake.rb list.rb option.rb test], @lists.list
  end

  def test_list_all
    assert_equal %w[. .. .gitkeep empty.rb fake.rb list.rb option.rb test], @lists.list_all
  end

  def test_divide
    assert_equal [[1, 4, 7], [2, 5, 8], [3, 6, 9]], @lists.divide([1, 2, 3, 4, 5, 6, 7, 8, 9])
    assert_equal [[1, 3, 5], [2, 4]], @lists.divide([1, 2, 3, 4, 5])
  end
end
