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
  end
end
