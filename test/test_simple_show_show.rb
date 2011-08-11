require 'test_helper'

class SimpleShowShowTest < SimpleShowTestCase

  test ':if => true/false' do
    doc = Nokogiri::HTML.fragment(
      simple_show_for @philip do |s| 
        o  = ActiveSupport::SafeBuffer.new
        o += s.show :name, :if => true
        o += s.show :phone, :if => false
        o
      end
    )
    assert_equal ['Name:'], doc.css('label').map(&:text)
  end

  test ':if => :record_method' do
    def @philip.method_returning_true; true; end
    def @philip.method_returning_false; false; end
    doc = Nokogiri::HTML.fragment(
      simple_show_for @philip do |s| 
        o  = ActiveSupport::SafeBuffer.new
        o += s.show :name, :if => :method_returning_true
        o += s.show :phone, :if => :method_returning_false
        o
      end
    )
    assert_equal ['Name:'], doc.css('label').map(&:text)
  end

  test ':if => {lambda}' do
    doc = Nokogiri::HTML.fragment(
      simple_show_for @philip do |s| 
        o  = ActiveSupport::SafeBuffer.new
        o += s.show :name, :if => lambda { true }
        o += s.show :phone, :if => lambda { false }
        o
      end
    )
    assert_equal ['Name:'], doc.css('label').map(&:text)
  end

  test ':unless => true/false' do
    doc = Nokogiri::HTML.fragment(
      simple_show_for @philip do |s| 
        o  = ActiveSupport::SafeBuffer.new
        o += s.show :name, :unless => true
        o += s.show :phone, :unless => false
        o
      end
    )
    assert_equal ['Phone:'], doc.css('label').map(&:text)
  end

  test ':unless => :record_method' do
    def @philip.method_returning_true; true; end
    def @philip.method_returning_false; false; end
    doc = Nokogiri::HTML.fragment(
      simple_show_for @philip do |s| 
        o  = ActiveSupport::SafeBuffer.new
        o += s.show :name, :unless => :method_returning_true
        o += s.show :phone, :unless => :method_returning_false
        o
      end
    )
    assert_equal ['Phone:'], doc.css('label').map(&:text)
  end

  test ':unless => {lambda}' do
    doc = Nokogiri::HTML.fragment(
      simple_show_for @philip do |s| 
        o  = ActiveSupport::SafeBuffer.new
        o += s.show :name, :unless => lambda { true }
        o += s.show :phone, :unless => lambda { false }
        o
      end
    )
    assert_equal ['Phone:'], doc.css('label').map(&:text)
  end



end
