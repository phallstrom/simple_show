require 'test_helper'

class SimpleShowValueTest < SimpleShowTestCase

  test 'values and value overrides' do
    doc = Nokogiri::HTML.fragment(
      simple_show_for @philip do |s| 
        o  = ActiveSupport::SafeBuffer.new
        o += s.show :name
        o += s.show(:email) {|o| o.email.upcase }
        o += s.show :phone, :value => '867-5309'
        o
      end
    )
    assert_equal 'Philip Hallstrom', doc.css('span.value')[0].text
    assert_equal 'PHILIP@PJKH.COM', doc.css('span.value')[1].text
    assert_equal '867-5309', doc.css('span.value')[2].text
  end

end
