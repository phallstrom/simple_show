require 'test_helper'

class SimpleShowValueTest < SimpleShowTestCase

  def setup
    super
    @doc = Nokogiri::HTML.fragment(
      simple_show_for @philip do |s| 
        o  = ActiveSupport::SafeBuffer.new
        o += s.show :name
        o += s.show(:email) {|o| o.email.upcase }
        o += s.show :phone, :value => '867-5309'
        o += s.show :born_on, :format => '%B %d'
        o += s.show :born_on, :format => :mmddyy
        o += s.show(:html) {|o| '<b>html</b>' }
        o += s.show :handicap, :format => '%.3f'
        o += s.show :name, :format => '%20s'
        o
      end
    )
  end

  test 'values and value overrides' do
    assert_equal 'Philip Hallstrom', @doc.css('span.value')[0].text
    assert_equal 'PHILIP@PJKH.COM', @doc.css('span.value')[1].text
    assert_equal '867-5309', @doc.css('span.value')[2].text
  end

  test 'date/time with formatting' do
    assert_equal 'May 24', @doc.css('span.value')[3].text
    assert_equal '05/24/74', @doc.css('span.value')[4].text
  end

  test 'values containing html' do
    assert_equal '<b>html</b>', @doc.css('span.value')[5].inner_html
  end

  test 'numbers with formatting' do
    assert_equal '6.500', @doc.css('span.value')[6].text
  end

  test 'strings with formatting' do
    assert_equal '    Philip Hallstrom', @doc.css('span.value')[7].text
  end

end
