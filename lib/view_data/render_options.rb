module ViewData
  class RenderOptions
    def initialize(options)
      @options = options
    end

    # ex: "application"
    def layout
      @layout ||= ''#ViewData::Layout.new(@options[:layout].call.identifier.split('/').last)
    end

    # ex: "posts/index"
    def template
      @template ||= ViewData::Template.new(_template(exist_prefixes.first)) if exist_prefixes.any?
    end

    def exist_prefixes
      @exist_prefixes ||= @options[:prefixes].select{ |prefix|
        path = ::Rails.root.join('app/views', _template(prefix)).to_s + '.*'
        Dir.glob(path).any?
      }
    end

    private
      def _template(prefix)
        [prefix, @options[:template]].join('/')
      end
  end
end
