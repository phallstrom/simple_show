require 'test_helper'

class SimpleShowTest < ActiveSupport::TestCase
  test 'setup block yields self' do
    SimpleShow.setup do |config|
      assert_equal SimpleShow, config
    end
  end
end
