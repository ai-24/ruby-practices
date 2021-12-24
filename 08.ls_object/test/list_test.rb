# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/list'

class ListTest < Minitest::Test
  def setup
    @lists = List.new
  end

  def test_list
    assert_equal %w[bin empty.rb fake.rb lib test], @lists.list
  end

  def test_list_all
    assert_equal %w[. .. .gitkeep bin empty.rb fake.rb lib test], @lists.list_all
  end

  def test_adjust
    assert_equal [[1, 4, 7], [2, 5, 8], [3, 6, 9]], @lists.adjust([1, 2, 3, 4, 5, 6, 7, 8, 9])
    assert_equal [[1, 3, 5], [2, 4, nil]], @lists.adjust([1, 2, 3, 4, 5])
  end
end
