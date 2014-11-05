module ViewData
  class DSL
    class Context
      attr_reader :root_node

      def initialize(data_name, data_node)
        @data_name = data_name
        @root_node = data_node
      end

      def method_missing(method, *args, &block)
        args, val = extract(method, args, block)
        attr(name: method, value: val, args: args, &block)
      end

      def sequence(attr)
        value = Sequences.find("#{ @data_name }:#{ attr }").next
        root_node.add_node(create_node(value, attr))
      end

      def extract(method, args, block = nil)
        if block.present?
          [args, InsideContext.new(self).instance_eval(&block)]
        elsif args.any? && !block.present?
          [[], args.first]
        else
          [[], nil]
        end
      end

      def create_node(value = nil, name = '', args = [], nodes = [])
        Data::Node.new(value: value, name: name, args: args, nodes: nodes)
      end

      def extract_and_create_node(method, args, block)
        args, val = extract(method, args, block)
        create_node(val, method, args)
      end

      def attr(name: '', value: nil, args: [], &block)
        exist_node = root_node.find_node(name, args)
        if exist_node.present?
          node = exist_node
        else
          node = create_node(value, name, args)
          root_node.add_node(node)
        end
        ChainContext.new(self, node)
      end
    end

    class InsideContext < BasicObject
      def initialize(parent_context)
        @parent_context = parent_context
      end

      def method_missing(method, *args, &block)
        @parent_context.root_node.send(method, *args, &block)
      end
    end

    class ChainContext < BasicObject
      def initialize(parent_context, parent_node)
        @parent_context = parent_context
        @parent_node = parent_node
      end

      def method_missing(method, *args, &block)
        node = @parent_context.extract_and_create_node(method, args, block)
        @parent_node.add_node(node)
        ChainContext.new(@parent_context, node)
      end
    end
  end
end
