def test_skip(method, field1, field2, label1, label2)
  first_label = field1.to_s.titleize

  test ':if => true/false' do
    doc = Nokogiri::HTML.fragment(
      simple_show_for(@philip) do |s|
        o  = ActiveSupport::SafeBuffer.new
        o += s.send(method, field1, if: true)
        o += s.send(method, field2, if: false)
        o
      end
    )
    assert_equal [label1], doc.css('label').map(&:text)
  end

  test ':if => :record_method' do
    def @philip.method_returning_true
      true
    end
    def @philip.method_returning_false
      false
    end
    doc = Nokogiri::HTML.fragment(
      simple_show_for(@philip) do |s|
        o  = ActiveSupport::SafeBuffer.new
        o += s.send(method, field1, if: :method_returning_true)
        o += s.send(method, field2, if: :method_returning_false)
        o
      end
    )
    assert_equal [label1], doc.css('label').map(&:text)
  end

  test ':if => {lambda}' do
    doc = Nokogiri::HTML.fragment(
      simple_show_for(@philip) do |s|
        o  = ActiveSupport::SafeBuffer.new
        o += s.send(method, field1, if: -> { true })
        o += s.send(method, field2, if: -> { false })
        o
      end
    )
    assert_equal [label1], doc.css('label').map(&:text)
  end

  test ':unless => true/false' do
    doc = Nokogiri::HTML.fragment(
      simple_show_for(@philip) do |s|
        o  = ActiveSupport::SafeBuffer.new
        o += s.send(method, field1, unless: true)
        o += s.send(method, field2, unless: false)
        o
      end
    )
    assert_equal [label2], doc.css('label').map(&:text)
  end

  test ':unless => :record_method' do
    def @philip.method_returning_true
      true
    end
    def @philip.method_returning_false
      false
    end
    doc = Nokogiri::HTML.fragment(
      simple_show_for(@philip) do |s|
        o  = ActiveSupport::SafeBuffer.new
        o += s.send(method, field1, unless: :method_returning_true)
        o += s.send(method, field2, unless: :method_returning_false)
        o
      end
    )
    assert_equal [label2], doc.css('label').map(&:text)
  end

  test ':unless => {lambda}' do
    doc = Nokogiri::HTML.fragment(
      simple_show_for(@philip) do |s|
        o  = ActiveSupport::SafeBuffer.new
        o += s.send(method, field1, unless: -> { true })
        o += s.send(method, field2, unless: -> { false })
        o
      end
    )
    assert_equal [label2], doc.css('label').map(&:text)
  end

  test ':if_attr => :record_method' do
    field1_attr = @philip.send(field1)
    def field1_attr.method_returning_true
      true
    end
    field2_attr = @philip.send(field2)
    def field2_attr.method_returning_false
      false
    end
    doc = Nokogiri::HTML.fragment(
      simple_show_for(@philip) do |s|
        o  = ActiveSupport::SafeBuffer.new
        o += s.send(method, field1, if_attr: :method_returning_true)
        o += s.send(method, field2, if_attr: :method_returning_false)
        o
      end
    )
    assert_equal [label1], doc.css('label').map(&:text)
  end

  test ':unless_attr => :record_method' do
    field1_attr = @philip.send(field1)
    def field1_attr.method_returning_true
      true
    end
    field2_attr = @philip.send(field2)
    def field2_attr.method_returning_false
      false
    end
    doc = Nokogiri::HTML.fragment(
      simple_show_for(@philip) do |s|
        o  = ActiveSupport::SafeBuffer.new
        o += s.send(method, field1, unless_attr: :method_returning_true)
        o += s.send(method, field2, unless_attr: :method_returning_false)
        o
      end
    )
    assert_equal [label2], doc.css('label').map(&:text)
  end
end

