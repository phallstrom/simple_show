require 'test_helper'

class SimpleShowForTest < SimpleShowTestCase
  test 'simple_show_for raises error without a block' do
    assert_raise ArgumentError do
      simple_show_for
    end
  end

  test 'html wrapper includes the correct id and class' do
    doc = Nokogiri::HTML.fragment(simple_show_for(@philip) do |_s|
      ''
    end)
    assert_equal %w(simple_show golfer), doc.at('div').attr('class').split(/\s+/)
    assert_equal "golfer_#{@philip.id}", doc.at('div').attr('id')
  end

  test 'last tag is a BR that clears all when enabled' do
    clear_on_close = SimpleShow.clear_on_close
    SimpleShow.clear_on_close = true
    doc = Nokogiri::HTML.fragment(simple_show_for(@philip) do |_s|
      ''
    end)
    SimpleShow.clear_on_close = clear_on_close
    assert_equal 'div', doc.at('div').elements.last.name
    assert_equal 'clear', doc.at('div').elements.last.attr('class')
  end

  test 'last tag is not a div/clear when disabled' do
    clear_on_close = SimpleShow.clear_on_close
    SimpleShow.clear_on_close = false
    doc = Nokogiri::HTML.fragment(simple_show_for(@philip) do |_s|
      ''
    end)
    assert_not_equal 'clear', doc.at('div').elements.last.try(:attr, 'class')
    SimpleShow.clear_on_close = clear_on_close
  end
end
