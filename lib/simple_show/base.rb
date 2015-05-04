module SimpleShow
  class Base
    def initialize(binding, record, options = {})
      @binding = binding
      @record  = record
      @options = options
    end

    def show(attr, options = {}, &block)
      return nil if skip?(attr, options)

      output = label(attr, options, &block)
      output += value(attr, options, &block)

      wrap_output(SimpleShow.wrapper_tag, SimpleShow.wrapper_class, output)
    end

    def show_collection(attr, options = {}, &block)
      return nil if skip?(attr, options)

      output = label(attr, options, &block)

      value = wrap_output(SimpleShow.collection_tag, SimpleShow.collection_class) do
        @record.send(attr).map do |attr_item|
          wrap_output(SimpleShow.collection_item_tag, SimpleShow.collection_item_class) do
            block_given? ? @binding.capture(attr_item, &block) : attr_item
          end
        end.join.html_safe
      end

      output += value

      wrap_output(SimpleShow.wrapper_tag, SimpleShow.wrapper_class, output)
    end

    def label(attr, options = {}, &block)
      return nil if skip?(attr, options)

      output = [SimpleShow.label_prefix, options[:label] || @record.class.human_attribute_name(attr), SimpleShow.label_suffix].compact.join

      wrap_output(SimpleShow.label_tag, SimpleShow.label_class, output)
    end

    def value(attr, options = {}, &block)
      return nil if skip?(attr, options)

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

      output = [SimpleShow.value_prefix, value, SimpleShow.value_suffix].compact.join.html_safe
      field_type = @record.class.columns_hash[attr.to_s].instance_variable_get(:@type)
      html_class = [SimpleShow.value_class, field_type].compact

      wrap_output(SimpleShow.value_tag, html_class, output)
    end

    def object
      @record
    end

    private

    def wrap_output(tag, html_class, output=nil, &block)
      output = yield if block_given?
      if tag.nil?
        output
      else
        @binding.content_tag(tag, output, :class => html_class)
      end
    end

    def skip?(attr, options)
      if options.key? :if
        case options[:if]
        when Symbol
          options[:if] = @record.send(options[:if])
        when Proc
          options[:if] = options[:if].call
        end
        return true if options[:if] == false
      end

      if options.key? :unless
        case options[:unless]
        when Symbol
          options[:unless] = @record.send(options[:unless])
        when Proc
          options[:unless] = options[:unless].call
        end
        return true unless options[:unless] == false
      end

      if options.key? :if_attr
        case options[:if_attr]
        when Symbol
          options[:if_attr] = @record.send(attr).send(options[:if_attr])
        end
        return true if options[:if_attr] == false
      end

      if options.key? :unless_attr
        case options[:unless_attr]
        when Symbol
          options[:unless_attr] = @record.send(attr).send(options[:unless_attr])
        end
        return true unless options[:unless_attr] == false
      end

      return false
    end
  end
end
