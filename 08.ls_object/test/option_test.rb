# frozen_string_literal: true

require 'minitest/autorun'
require '../option'

class OptionTest < Minitest::Test
  def setup
    @option = Option.new
    @lists_object = List.new
    @file_lists = @lists_object.list
  end

  def test_calculate_block
    assert_equal 24, @option.calculate_block(@file_lists)
  end

  def test_derive
    assert_equal(['list_test.rb', 'option_long_test.rb', 'option_test.rb', 'test1@ -> option_test.rb'], @file_lists.map { |list| @option.derive(list) })
  end

  def test_classify
    assert_equal '-', @option.classify('option_test.rb')
  end

  def test_authorize
    assert_equal 'rw-r--r--', @option.authorize('option_test.rb').join
  end
end
