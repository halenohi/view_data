module ViewData
  class Data
    class << self
      def find(layout_or_template)
        case layout_or_template
        when ViewData::Layout
          
        when ViewData::Template
          
        end
      end
    end

    def present?
      true
    end

    def to_assigns
      { hoge: }
    end
  end
end
