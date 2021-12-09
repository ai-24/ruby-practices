# frozen_string_literal: true

require 'minitest/autorun'
require '../option_long'

class OptionLongTest < Minitest::Test
def setup
  @option = OptionLong.new
  @lists = List.new
end

end