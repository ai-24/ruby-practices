# frozen_string_literal: true

require 'minitest/autorun'
require './game'

class GameTest < Minitest::Test
  def setup
    @game_score = Game.new('1,2,3,4,5,1,X')
    @second_game_score = Game.new('1,3,X,5,5,3')
  end

  def test_split
    assert_equal %w[1 2 3 4 5 1 X 0], @game_score.split
    assert_equal %w[1 3 X 0 5 5 3], @second_game_score.split
  end

  def test_frame
    assert_equal [%w[1 2], %w[3 4], %w[5 1], %w[X 0]], @game_score.frame
    assert_equal [%w[1 3], %w[X 0], %w[5 5], %w[3]], @second_game_score.frame
  end

  def test_total_score
    total1 = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5')
    assert_equal 139, total1.total_score

    total2 = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X')
    assert_equal 164, total2.total_score

    total3 = Game.new('0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4')
    assert_equal 107, total3.total_score

    total4 = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0')
    assert_equal 134, total4.total_score

    total5 = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,1,8')
    assert_equal 144, total5.total_score

    total6 = Game.new('X,X,X,X,X,X,X,X,X,X,X,X')
    assert_equal 300, total6.total_score
  end
end
