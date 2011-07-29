require 'simple_show/base'

module SimpleShow

  mattr_accessor :show_class
  @@show_class = :simple_show

  mattr_accessor :wrapper_tag
  @@wrapper_tag = :div

  mattr_accessor :wrapper_class
  @@wrapper_class = :show

  mattr_accessor :label_tag
  @@label_tag = :label

  mattr_accessor :label_class
  @@label_class = nil

  mattr_accessor :label_prefix
  @@label_prefix = nil

  mattr_accessor :label_suffix
  @@label_suffix = ':'

  mattr_accessor :value_tag
  @@value_tag = :span

  mattr_accessor :value_class
  @@value_class = :value

  mattr_accessor :value_prefix
  @@value_prefix = nil

  mattr_accessor :value_suffix
  @@value_suffix = nil

  mattr_accessor :clear_on_close
  @@clear_on_close = true

  # Default way to setup SimpleShow. Run rails generate simple_show:install
  # to create a fresh initializer with all configuration values.
  def self.setup
    yield self
  end

end
