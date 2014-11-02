module ViewData
  class DSL
    class Context < Struct.new(:data_name)
      def method_missing(method, *args, &block)
        values.merge!(method => extract_value(method, args, block))
        ChainContext.new(self, method)
      end

      def values
        @values ||= {}
      end

      def sequence(attr)
        values.merge!(
          attr => ViewData::DSL::Sequences.find("#{ data_name }:#{ attr }").next
        )
      end

      def extract_value(method, args, block = nil)
        if args.blank? && block.present?
          InsideContext.new(self).instance_eval(&block)
        elsif args.any? && block.present?
          target_value = values[method]
          if target_value.is_a?(MultipleValue)
            target_value.add(args.first, block)
          else
            MultipleValue.new(target_value, args.first, block)
          end
        elsif args.any?
          args.first
        end
      end
    end

    class InsideContext < Struct.new(:parent)
      def method_missing(method, *args)
        parent.values[method]
      end
    end

    class ChainContext < Struct.new(:parent, :before_method)
      def method_missing(method, *args, &block)
        value[before_method][method] = parent.extract_value(method, args, block)
        parent.values.merge!(value)
      end

      def value
        @value ||= { before_method => {} }
      end
    end

    class MultipleValue
      def initailize(base_value, key, block)
      end
    end
  end
end
