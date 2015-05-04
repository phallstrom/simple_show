module SimpleShow
  module ActionViewExtensions
    module FormHelper
      def simple_show_for(record, options = {}, &block)
        fail ArgumentError, 'Missing block' unless block_given?

        options[:html] ||= {}
        options[:html][:id] ||= dom_id(record)
        options[:html][:class] = "#{SimpleShow.show_class} #{dom_class(record)} #{options[:html][:class]}".strip

        output = capture(SimpleShow::Base.new(self, record, options), &block)
        output.concat content_tag(:div, '', class: 'clear') if SimpleShow.clear_on_close

        content_tag(:div, output, id: options[:html][:id], class: options[:html][:class])
      end
    end
  end
end

ActionView::Base.send :include, SimpleShow::ActionViewExtensions::FormHelper
