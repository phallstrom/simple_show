require 'test_helper'
require 'skip_helper'

class SimpleShowShowTest < SimpleShowTestCase
  test_skip(:show, :name, :phone, 'Name:', 'Phone:')
end

