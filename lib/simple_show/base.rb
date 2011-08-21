module SimpleShow
  class Base
    def initialize(binding, record, options = {})
      @binding = binding
      @record  = record
      @options = options
    end

    def show(attr, options = {}, &block)
      if options.key? :if
        case options[:if]
        when Symbol
          options[:if] = @record.send(options[:if])
        when Proc
          options[:if] = options[:if].call
        end
        return nil if options[:if] == false
      end
      if options.key? :unless
        case options[:unless]
        when Symbol
          options[:unless] = @record.send(options[:unless])
        when Proc
          options[:unless] = options[:unless].call
        end
        return nil unless options[:unless] == false
      end

      output = label(attr, options, &block)
      output += value(attr, options, &block)

      if SimpleShow.wrapper_tag.nil?
        output
      else
        @binding.content_tag(SimpleShow.wrapper_tag, output, :class => SimpleShow.wrapper_class)
      end
    end

    def label(attr, options = {}, &block)
      @binding.content_tag(SimpleShow.label_tag, :class => SimpleShow.label_class) do
        [SimpleShow.label_prefix, options[:label] || @record.class.human_attribute_name(attr), SimpleShow.label_suffix].compact.join
      end
    end

    def value(attr, options = {}, &block)
      if block_given?
        value = yield(@record)
      else
        value = options[:value] || @record.send(attr)
      end
      if !value.nil?
        if options[:format].present?
          if [:datetime, :timestamp, :time, :date].include?(@record.class.columns_hash[attr.to_s].type)
            value = value.send(options[:format].is_a?(Symbol) ? :to_s : :strftime, options[:format])
          else
            value = options[:format] % value
          end
        elsif (helper = (SimpleShow.helpers.keys & options.keys).first).present?
          args = []
          args << value
          args << options[helper] if options[helper].is_a? Hash
          value = @binding.send(SimpleShow.helpers[helper], *args)
        end
      end

      @binding.content_tag(SimpleShow.value_tag, :class => SimpleShow.value_class) do
        [SimpleShow.value_prefix, value, SimpleShow.value_suffix].compact.join.html_safe
      end
    end
  end
end
