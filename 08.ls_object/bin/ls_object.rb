# frozen_string_literal: true

require_relative '../lib/option'
require_relative '../lib/list'

@option_object = Option.new
@list = List.new
selected = Option.inform
result = selected[:a] ? @list.list_all : @list.list
sorted_lists = selected[:r] ? @option_object.print_reverse(result) : result
selected[:l] ? @option_object.print_long(sorted_lists) : final_result = @list.adjust(sorted_lists)
@list.display(*final_result)
