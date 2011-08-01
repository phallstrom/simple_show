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

class SimpleShowTestCase < ActiveSupport::TestCase
  include SimpleShow::ApplicationHelper
  include ActionController::RecordIdentifier
  include ActionView::Helpers::CaptureHelper
  include ActionView::Helpers::TagHelper
  attr_accessor :output_buffer
end

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

class Golfer < ActiveRecord::Base
end
