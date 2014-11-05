class ViewData::DSL
  def data(name, nodes = [], &block)
    data_node = ViewData::Data::Node.new(name: name)
    if block_given?
      context = ViewData::DSL::Context.new(name, data_node, dsl)
      context.instance_eval(&block)
    end
    unless nodes.length.zero?
      data_node.add_node(*nodes)
    end
    data_nodes[data_node_name(name)] = data_node
  end

  def data_nodes
    @data_nodes ||= {}
  end

  def collection(name, options = {})
    length = options[:length] || 1
    length.times.map{ @data_nodes[make_full_name(name)] }
  end

  private
    def data_node_name(name)
      splited_path = __FILE__.split('/')
      [splited_path[-2], splited_path[-1].sub(/\..+$/, '')].join('/') +
      ":#{ name }"
    end

    def make_full_name(name)
      name = name.to_s
      if !name.include?('/')
        "#{ name.pluralize }/#{ name }:#{ name }"
      elsif !name.include?(':')
        "#{ name }:#{ name.split('/').last }"
      else
        name
      end
    end
end
