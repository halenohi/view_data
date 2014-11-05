module ViewData
  class DSL
    def data(name, &block)
      data_node = ViewData::Data::Node.new(name: name)
      if block_given?
        context = ViewData::DSL::Context.new(name, data_node)
        context.instance_eval(&block)
      end
      data_nodes[name] = data_node
    end

    def data_nodes
      @data_nodes ||= {}
    end
  end
end
