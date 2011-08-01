module SimpleShow
  class Base
    def initialize(binding, record, options = {})
      @binding = binding
      @record  = record
      @options = options
    end

    def show(attr, options = {}, &block)
      output = label(attr, options, &block)
      output += value(attr, options, &block)
      if SimpleShow.wrapper_tag.nil?
        @binding.output_buffer += output
      else
        @binding.output_buffer += @binding.content_tag(SimpleShow.wrapper_tag, output, :class => SimpleShow.wrapper_class)
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
      @binding.content_tag(SimpleShow.value_tag, :class => SimpleShow.value_class) do
        [SimpleShow.value_prefix, value, SimpleShow.value_suffix].compact.join
      end
    end
  end
end
