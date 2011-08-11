require 'rubygems'
require 'bundler/setup'
require 'nokogiri'

require 'test/unit'
require 'pp'

require 'active_record'
require 'active_model'
require 'action_controller'
require 'action_view'
require 'action_view/base'
require 'action_view/template'

require 'simple_show'
require 'app/helpers/simple_show/application_helper'

################################################################################

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
ActiveRecord::Migration.verbose = false

ActiveRecord::Schema.define(:version => 1) do
  create_table :golfers do |t|
    t.column :name, :string
    t.column :phone, :string
    t.column :email, :string
    t.column :born_on, :date
    t.column :is_left_handed, :boolean
    t.column :handicap, :decimal, :scale => 3, :precision => 1
    t.timestamps
  end
end

################################################################################

::Time::DATE_FORMATS[:mmddyy] = ::Date::DATE_FORMATS[:mmddyy] = '%m/%d/%y'

################################################################################

class Golfer < ActiveRecord::Base
end

################################################################################

class SimpleShowTestCase < ActiveSupport::TestCase
  include SimpleShow::ApplicationHelper
  include ActionController::RecordIdentifier
  include ActionView::Helpers::CaptureHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::NumberHelper
  attr_accessor :output_buffer

  def setup
    @philip = Golfer.create!(
      :name           => 'Philip Hallstrom',
      :phone          => '3604801209',
      :email          => 'philip@pjkh.com',
      :born_on        => Date.civil(1974, 5, 24),
      :is_left_handed => true,
      :handicap       => 6.5
    )
  end
end

