module ViewData
  class DSL
    class Sequences
      include Singleton

      class << self
        def find(name)
          instance.collection(name)
        end
      end

      def collection(name)
        @collection ||= {}
        @collection[name] ||= Sequence.new
      end
    end

    class Sequence
      def initialize
        @count = 0
      end

      def next
        @count += 1
      end
    end
  end
end
