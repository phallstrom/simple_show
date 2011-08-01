require 'test_helper'

class SimpleShowForTest < ActiveSupport::TestCase
  include SimpleShow::ApplicationHelper
  include ActionController::RecordIdentifier
  include ActionView::Helpers::CaptureHelper
  include ActionView::Helpers::TagHelper

  attr_accessor :output_buffer

  def dom_id(record, prefix=nil)
    "dom_id"
  end

  def dom_class(record, prefix=nil)
    "dom_class"
  end

  def setup
    @output_buffer = ''
  end

  test 'simple_show_for raises error without a block' do
    assert_raise ArgumentError do
      simple_show_for 
    end
  end

  test 'foo' do
   pp (simple_show_for Object.new do 
     |f| 'xxx' 
   end)
  end

end
