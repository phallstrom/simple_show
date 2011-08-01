require 'test_helper'

class SimpleShowLabelTest < SimpleShowTestCase

  test 'labels and label overrides' do
    doc = Nokogiri::HTML.fragment(simple_show_for @philip do |f| 
      f.show :name
      f.show :phone, :label => 'Cell Phone'
    end)
    assert_equal 'Name:', doc.css('label').first.text
    assert_equal 'Cell Phone:', doc.css('label').last.text
  end

end
