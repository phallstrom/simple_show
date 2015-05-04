require 'test_helper'
require 'skip_helper'

class SimpleShowShowCollectionTest < SimpleShowTestCase
  test_skip(:show_collection, :rounds, :clubs, 'Rounds:', 'Clubs:')

  test 'default display works' do
    doc = Nokogiri::HTML.fragment(
      simple_show_for(@philip) do |s|
        o  = ActiveSupport::SafeBuffer.new
        o += s.show :name
        o += s.show_collection :rounds
        o
      end
    )
    assert_equal 'Rounds:', doc.css('label').last.text
    assert_equal [@round1, @round2].map(&:to_s).sort, doc.css('.show_collection_item').map(&:text).sort
  end

  test 'block display works' do
    doc = Nokogiri::HTML.fragment(
      simple_show_for(@philip) do |s|
        o  = ActiveSupport::SafeBuffer.new
        o += s.show :name
        o += s.show_collection :rounds do |round|
          nested_o  = ActiveSupport::SafeBuffer.new
          nested_o += "#{round} - #{round.score}"
          nested_o
        end
        o
      end
    )
    assert_equal 'Rounds:', doc.css('label').last.text
    assert_equal [@round1, @round2].map{|r| "#{r} - #{r.score}" }.sort, doc.css('.show_collection_item').map(&:text).sort
  end
end
