require 'test_helper'

class SimpleShowLabelTest < SimpleShowTestCase

  test 'labels and label overrides' do
    doc = Nokogiri::HTML.fragment(
      simple_show_for @philip do |s| 
        o  = ActiveSupport::SafeBuffer.new
        o += s.show :name
        o += s.show :phone, :label => 'Cell Phone'
        o
      end
    )
    assert_equal 'Name:', doc.css('label').first.text
    assert_equal 'Cell Phone:', doc.css('label').last.text
  end

end
