# frozen_string_literal: true

require_relative 'game'

g = Game.new(ARGV[0])
puts g.final_calculate
