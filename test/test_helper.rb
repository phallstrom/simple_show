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

################################################################################

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
ActiveRecord::Migration.verbose = false

ActiveRecord::Schema.define(version: 1) do
  create_table :golfers do |t|
    t.column :name, :string
    t.column :phone, :string
    t.column :email, :string
    t.column :born_on, :date
    t.column :is_left_handed, :boolean
    t.column :handicap, :decimal, scale: 3, precision: 1
    t.timestamps
  end

  create_table :rounds do |t|
    t.references :golfer

    t.column :name, :string
    t.column :score, :integer
    t.timestamps
  end

  create_table :clubs do |t|
    t.references :golfer

    t.column :name, :string
    t.timestamps
  end
end

################################################################################

::Time::DATE_FORMATS[:mmddyy] = ::Date::DATE_FORMATS[:mmddyy] = '%m/%d/%y'

################################################################################

class Golfer < ActiveRecord::Base
  has_many :clubs
  has_many :rounds
end

class Round < ActiveRecord::Base
  belongs_to :golfer

  def to_s
    name
  end
end

class Club < ActiveRecord::Base
  belongs_to :golfer

  def to_s
    name
  end
end

################################################################################

module ActionView
  module Helpers
    module TagHelper
      def piglatin(str)
        str[1..-1] + str[0, 1] + 'ay'
      end
    end
  end
end

################################################################################

class SimpleShowTestCase < ActiveSupport::TestCase
  include SimpleShow::ActionViewExtensions::FormHelper
  include ActionController::RecordIdentifier
  include ActionView::Helpers::CaptureHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::NumberHelper
  attr_accessor :output_buffer

  def setup
    @philip = Golfer.create!(
      name: 'Philip Hallstrom',
      phone: '3604801209',
      email: 'philip@pjkh.com',
      born_on: Date.civil(1974, 5, 24),
      is_left_handed: true,
      handicap: 6.5
    )
    @round1 = Round.create!(
      name: 'Round 1',
      score: 72,
      golfer: @philip
    )
    @round2 = Round.create!(
      name: 'Round 2',
      score: 68,
      golfer: @philip
    )
  end
end
