ENV['RAILS_ENV'] = 'test'

require File.expand_path('../rails_app/config/environment.rb',  __FILE__)
require 'rails/test_help'

Rails.backtrace_cleaner.remove_silencers!
ActiveRecord::Migrator.migrate File.expand_path('../rails_app/db/migrate/', __FILE__)
