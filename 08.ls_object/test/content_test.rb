# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/content'

class ContentTest < Minitest::Test
  def test_lists
    assert_equal %w[bin empty.rb fake.rb lib test], Content.new.lists
  end
end
