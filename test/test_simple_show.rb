require 'test_helper'

class SimpleShowTest < SimpleShowTestCase
  test 'setup block yields self' do
    SimpleShow.setup do |config|
      assert_equal SimpleShow, config
    end
  end

  test 'default configuration' do
    assert_equal :simple_show, SimpleShow.show_class
    assert_equal :div, SimpleShow.wrapper_tag
    assert_equal :show, SimpleShow.wrapper_class
    assert_equal :label, SimpleShow.label_tag
    assert_equal nil, SimpleShow.label_class
    assert_equal nil, SimpleShow.label_prefix
    assert_equal ':', SimpleShow.label_suffix
    assert_equal :span, SimpleShow.value_tag
    assert_equal :value, SimpleShow.value_class
    assert_equal nil, SimpleShow.value_prefix
    assert_equal nil, SimpleShow.value_suffix
    assert_equal :ul, SimpleShow.collection_tag
    assert_equal :show_collection, SimpleShow.collection_class
    assert_equal :li, SimpleShow.collection_item_tag
    assert_equal :show_collection_item, SimpleShow.collection_item_class
    assert_equal true, SimpleShow.clear_on_close
  end
end
